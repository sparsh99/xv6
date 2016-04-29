#include "types.h"
#include "stat.h"
#include "user.h"

char buf[1000];

void
history(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0){
    write(1, buf, strlen(buf));
	}
  if(n < 0){
    printf(1, "History: read error\n");
    exit();
  }
}

int
main(int argc, char *argv[])
{
    int fd;

    char hist[10]={'h','\0'};

    if((fd = open(hist, 0)) < 0){
      printf(1, "History: cannot open %s\n", hist);
      exit();
    }
    history(fd);
    close(fd);
  exit();
}
