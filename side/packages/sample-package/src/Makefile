OBJS = \
	main.o

all: sample_app

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

clean:
	rm -f $(OBJS) sample_app

sample_app: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)
