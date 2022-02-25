# Basic Makefile with Auto Dependency Tracking and Seperated Project Directories
# Author: 	Silas Waxter
# Date:		02/24/22
# How it works:	
# 		-Dependency Tracking: http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
# 		-Output Files in Seperate Directory: https://www.youtube.com/watch?v=NPdagdEOBnI


##########
# directories for sources, objects, and dependencies
##########
OBJDIR := build/
DEPDIR := $(OBJDIR)dependencies/
#the space-seperated source directories (recursive search)
SRCDIRS := $(shell find src -type d -printf '%p ')


##########
# source, object, and dependancy files
##########
SRCS := $(shell find src -type f -name "*.c")
OBJS := $(patsubst %.c,$(OBJDIR)%.o,$(notdir $(SRCS)))
DEPS := $(patsubst %.o,$(DEPDIR)%.d,$(notdir $(OBJS)))

#Search in source directories for .c and .h files (vpath needs directories as colon-seperated)
vpath %.c $(subst :, ,$(SRCDIRS))
vpath %.h $(subst :, ,$(SRCDIRS))


##########
# Build Parameters
##########
APPBIN := application
CXX := gcc
CXXFLAGS := -c -O0 -Wall $(patsubst %,-I%,$(SRCDIRS))
# see gcc.gnu.org/onlinedocs/gcc-4.3.2/cpp/Invocation.html for flags
# see command section below for why extension is .Td
DEPGENFLAGS = -MMD -MT $@ -MP -MF $(DEPDIR)$*.Td
ARCHFLAGS := #-mcpu=cortex-m0plus -mthumb -mfloat-abi=soft
LDFLAGS :=


##########
# Directives
##########
# Post Process Dependency
# gcc has been reported to generate a dependency file with a more recent timestamp than
# the object file.
# Solution: 	have gcc output dependency files with temp suffix, 
# 		then rename files with proper suffix (enforces this post-processing for all dep. files),
# 		then touch file to update timestamp
POSTPROCDEP = mv -f $(DEPDIR)$*.Td $(DEPDIR)$*.d && touch $@



.PHONY : all clean

all: $(APPBIN)

$(APPBIN): $(OBJS)
	$(CXX) $(LDFLAGS) $^ -o $@

$(OBJDIR)%.o: %.c $(DEPDIR)%.d | $(DEPDIR)
	$(CXX) $(CXXFLAGS) $(DEPGENFLAGS) -o $@ -c $<
	$(POSTPROCDEP)

# empty targets for handling missing .d files
$(DEPS):

# make dependency directory if it doesn't exist
$(DEPDIR):
	@echo making directory at $(DEPDIR)
	@mkdir -p $@

clean:
	rm -rf $(OBJDIR)* $(APPBIN)

# append the contents of the dependency files that exist;
# see "Avoiding Re-exec of make" section in Dependencing Tracking reference (top of page)
include $(wildcard $(DEPS))
