#include "types.h"
#include "stat.h"
#include "user.h"

char buf[512];

void
history(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    write(1, buf, n);
  if(n < 0){
    printf(1, "History: read error\n");
    exit();
  }
}

int
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    history(0);
    exit();
  }
  char hist[10]={'h','\0'};
  for(i = 1; i < argc; i++){
    if((fd = open(hist, 0)) < 0){
      printf(1, "History: cannot open %s\n", hist);
      exit();
    }
    history(fd);
    close(fd);
  }
  exit();
}
