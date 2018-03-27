CPP = gcc

TARGET	= fpv_rx

DIR		= ./receiver

INC		+= -I./receiver

LDFLAGS += -lpthread -ldl -lm -lrt -lpcap
CFLAGS	= -g -Wall

OBJPATH	= ./objs

FILES	= $(foreach dir,$(DIR),$(wildcard $(dir)/*.c))

OBJS	= $(patsubst %.c,%.o,$(FILES))

all:$(OBJS) $(TARGET)

$(OBJS):%.o:%.c
	$(CPP) $(CFLAGS) $(INC) -c -o $(OBJPATH)/$(notdir $@) $< 

$(TARGET):$(OBJPATH)
	$(CPP) -o $@ $(OBJPATH)/*.o $(LDFLAGS)

#$(OBJPATH):
#	mkdir -p $(OBJPATH)

clean:
	-rm -f $(OBJPATH)/*.o
	-rm -f $(TARGET)