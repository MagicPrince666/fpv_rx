CPP = g++

TARGET	= fpv_rx

DIR		= ./receiver ./ffmpeg ./ringbuf

INC		+= -I./receiver -I./ringbuf -I./ffmpeg -I/usr/local/include

LDFLAGS += -lavformat -lavcodec -lavutil -lswscale -lswresample -lx264 -lSDL2 -lpthread -ldl -lm -lrt -lpcap -lz
CFLAGS	= -g -Wall

OBJPATH	= ./objs

FILES	= $(foreach dir,$(DIR),$(wildcard $(dir)/*.cpp))

OBJS	= $(patsubst %.cpp,%.o,$(FILES))

all:$(OBJS) $(TARGET)

$(OBJS):%.o:%.cpp
	$(CPP) $(CFLAGS) $(INC) -c -o $(OBJPATH)/$(notdir $@) $< 

$(TARGET):$(OBJPATH)
	$(CPP) -o $@ $(OBJPATH)/*.o $(LDFLAGS) `sdl2-config --cflags --libs`

#$(OBJPATH):
#	mkdir -p $(OBJPATH)

clean:
	-rm -f $(OBJPATH)/*.o
	-rm -f $(TARGET)
