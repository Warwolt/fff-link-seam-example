# Define directories
OBJ_DIR = build
FAKE_DIR = fake
SRC_DIR = src
INC_DIR = inc

# Name output
PROGRAM = bin
PROD_LIB = build/prod.a

# Get source files
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst %.c,%.o, $(patsubst $(SRC_DIR)/%, $(OBJ_DIR)/%, $(SRC)))
FAKE_SRC = $(wildcard $(FAKE_DIR)/*.c)
FAKE_OBJ = $(patsubst %.c,%.o, $(patsubst $(FAKE_DIR)/%, $(OBJ_DIR)/%, $(FAKE_SRC)))

# compile flags
FLAGS =
INC = -I$(INC_DIR) -I$(FAKE_DIR)

.PHONY: clean

# Make binary
$(PROGRAM): $(PROD_LIB) $(FAKE_OBJ)
	@echo "linking $@"
	@gcc $^ $(FLAGS) -o $@

# Make production code library
$(PROD_LIB): $(OBJ)
	@echo "creating archive $@"
	@ar rc $@ $(OBJ)

# Make fakes

# Include dependencies
DEP = $(OBJ:%.o=%.d)
-include $(DEP)

# Compile program source
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "compiling $(notdir $<)"
	@gcc $< $(FLAGS) $(INC) $(DEF) -Werror -c -MMD -o $@

# Compile fake source
$(OBJ_DIR)/%.o: $(FAKE_DIR)/%.c
	@echo "compiling $(notdir $<)"
	@gcc $< $(FLAGS) $(INC) $(DEF) -Werror -c -MMD -o $@

clean:
	@echo cleaning..
	@rm -f $(PROGRAM)
	@rm -f $(OBJ_DIR)/*
	@rm -f $(DEP)

debug:
	@echo SRC = $(SRC)
	@echo INC = $(INC)
	@echo OBJ = $(OBJ)
	@echo DEP = $(DEP)
	@echo FAKE_SRC = $(FAKE_SRC)
	@echo FAKE_OBJ = $(FAKE_OBJ)
