CFLAGS += -Wall -Werror
EXTRA_CFLAGS += -I/usr/include/libnl3/ -DLIBNL_TINY
LDFLAGS=-L/lib/mipsel-linux-gnu

all: l2tp_client

l2tp_client: l2tp_client.o asyncns.o
        #$(CC) $(LDFLAGS) -o $@ $^ -lpthread -lnl-genl-3 -lrt -lresolv
        $(CC) $(LDFLAGS) -o $@ $^ -lpthread -lnl-3 -lnl-genl-3 -lrt -lresolv

%.o: %.c
        $(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(LDFAGS) -c -I. -o $@ $<

clean:
        rm -rf *.o l2tp_client
