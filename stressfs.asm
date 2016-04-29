
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
  14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
  1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
  22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 70 0a 00 00       	push   $0xa70
  30:	6a 01                	push   $0x1
  32:	e8 83 06 00 00       	call   6ba <printf>
  37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  3a:	83 ec 04             	sub    $0x4,%esp
  3d:	68 00 02 00 00       	push   $0x200
  42:	6a 61                	push   $0x61
  44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  4a:	50                   	push   %eax
  4b:	e8 be 01 00 00       	call   20e <memset>
  50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  5a:	eb 0d                	jmp    69 <main+0x69>
    if(fork() > 0)
  5c:	e8 da 04 00 00       	call   53b <fork>
  61:	85 c0                	test   %eax,%eax
  63:	7f 0c                	jg     71 <main+0x71>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  69:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
  6d:	7e ed                	jle    5c <main+0x5c>
  6f:	eb 01                	jmp    72 <main+0x72>
    if(fork() > 0)
      break;
  71:	90                   	nop

  printf(1, "write %d\n", i);
  72:	83 ec 04             	sub    $0x4,%esp
  75:	ff 75 f4             	pushl  -0xc(%ebp)
  78:	68 83 0a 00 00       	push   $0xa83
  7d:	6a 01                	push   $0x1
  7f:	e8 36 06 00 00       	call   6ba <printf>
  84:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  87:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  8b:	89 c2                	mov    %eax,%edx
  8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  90:	01 d0                	add    %edx,%eax
  92:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  95:	83 ec 08             	sub    $0x8,%esp
  98:	68 02 02 00 00       	push   $0x202
  9d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  a0:	50                   	push   %eax
  a1:	e8 dd 04 00 00       	call   583 <open>
  a6:	83 c4 10             	add    $0x10,%esp
  a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
  ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  b3:	eb 1e                	jmp    d3 <main+0xd3>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b5:	83 ec 04             	sub    $0x4,%esp
  b8:	68 00 02 00 00       	push   $0x200
  bd:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  c3:	50                   	push   %eax
  c4:	ff 75 f0             	pushl  -0x10(%ebp)
  c7:	e8 97 04 00 00       	call   563 <write>
  cc:	83 c4 10             	add    $0x10,%esp

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  d3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  d7:	7e dc                	jle    b5 <main+0xb5>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  d9:	83 ec 0c             	sub    $0xc,%esp
  dc:	ff 75 f0             	pushl  -0x10(%ebp)
  df:	e8 87 04 00 00       	call   56b <close>
  e4:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  e7:	83 ec 08             	sub    $0x8,%esp
  ea:	68 8d 0a 00 00       	push   $0xa8d
  ef:	6a 01                	push   $0x1
  f1:	e8 c4 05 00 00       	call   6ba <printf>
  f6:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
  f9:	83 ec 08             	sub    $0x8,%esp
  fc:	6a 00                	push   $0x0
  fe:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 101:	50                   	push   %eax
 102:	e8 7c 04 00 00       	call   583 <open>
 107:	83 c4 10             	add    $0x10,%esp
 10a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
 10d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 114:	eb 1e                	jmp    134 <main+0x134>
    read(fd, data, sizeof(data));
 116:	83 ec 04             	sub    $0x4,%esp
 119:	68 00 02 00 00       	push   $0x200
 11e:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
 124:	50                   	push   %eax
 125:	ff 75 f0             	pushl  -0x10(%ebp)
 128:	e8 2e 04 00 00       	call   55b <read>
 12d:	83 c4 10             	add    $0x10,%esp
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 130:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 134:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
 138:	7e dc                	jle    116 <main+0x116>
    read(fd, data, sizeof(data));
  close(fd);
 13a:	83 ec 0c             	sub    $0xc,%esp
 13d:	ff 75 f0             	pushl  -0x10(%ebp)
 140:	e8 26 04 00 00       	call   56b <close>
 145:	83 c4 10             	add    $0x10,%esp

  wait();
 148:	e8 fe 03 00 00       	call   54b <wait>
  
  exit();
 14d:	e8 f1 03 00 00       	call   543 <exit>

00000152 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
 155:	57                   	push   %edi
 156:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 157:	8b 4d 08             	mov    0x8(%ebp),%ecx
 15a:	8b 55 10             	mov    0x10(%ebp),%edx
 15d:	8b 45 0c             	mov    0xc(%ebp),%eax
 160:	89 cb                	mov    %ecx,%ebx
 162:	89 df                	mov    %ebx,%edi
 164:	89 d1                	mov    %edx,%ecx
 166:	fc                   	cld    
 167:	f3 aa                	rep stos %al,%es:(%edi)
 169:	89 ca                	mov    %ecx,%edx
 16b:	89 fb                	mov    %edi,%ebx
 16d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 170:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 173:	90                   	nop
 174:	5b                   	pop    %ebx
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    

00000178 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
 17b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 184:	90                   	nop
 185:	8b 45 08             	mov    0x8(%ebp),%eax
 188:	8d 50 01             	lea    0x1(%eax),%edx
 18b:	89 55 08             	mov    %edx,0x8(%ebp)
 18e:	8b 55 0c             	mov    0xc(%ebp),%edx
 191:	8d 4a 01             	lea    0x1(%edx),%ecx
 194:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 197:	0f b6 12             	movzbl (%edx),%edx
 19a:	88 10                	mov    %dl,(%eax)
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	84 c0                	test   %al,%al
 1a1:	75 e2                	jne    185 <strcpy+0xd>
    ;
  return os;
 1a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a6:	c9                   	leave  
 1a7:	c3                   	ret    

000001a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1ab:	eb 08                	jmp    1b5 <strcmp+0xd>
    p++, q++;
 1ad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1b5:	8b 45 08             	mov    0x8(%ebp),%eax
 1b8:	0f b6 00             	movzbl (%eax),%eax
 1bb:	84 c0                	test   %al,%al
 1bd:	74 10                	je     1cf <strcmp+0x27>
 1bf:	8b 45 08             	mov    0x8(%ebp),%eax
 1c2:	0f b6 10             	movzbl (%eax),%edx
 1c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c8:	0f b6 00             	movzbl (%eax),%eax
 1cb:	38 c2                	cmp    %al,%dl
 1cd:	74 de                	je     1ad <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	0f b6 00             	movzbl (%eax),%eax
 1d5:	0f b6 d0             	movzbl %al,%edx
 1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1db:	0f b6 00             	movzbl (%eax),%eax
 1de:	0f b6 c0             	movzbl %al,%eax
 1e1:	29 c2                	sub    %eax,%edx
 1e3:	89 d0                	mov    %edx,%eax
}
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    

000001e7 <strlen>:

uint
strlen(char *s)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1f4:	eb 04                	jmp    1fa <strlen+0x13>
 1f6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	01 d0                	add    %edx,%eax
 202:	0f b6 00             	movzbl (%eax),%eax
 205:	84 c0                	test   %al,%al
 207:	75 ed                	jne    1f6 <strlen+0xf>
    ;
  return n;
 209:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20c:	c9                   	leave  
 20d:	c3                   	ret    

0000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
 20e:	55                   	push   %ebp
 20f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 211:	8b 45 10             	mov    0x10(%ebp),%eax
 214:	50                   	push   %eax
 215:	ff 75 0c             	pushl  0xc(%ebp)
 218:	ff 75 08             	pushl  0x8(%ebp)
 21b:	e8 32 ff ff ff       	call   152 <stosb>
 220:	83 c4 0c             	add    $0xc,%esp
  return dst;
 223:	8b 45 08             	mov    0x8(%ebp),%eax
}
 226:	c9                   	leave  
 227:	c3                   	ret    

00000228 <strchr>:

char*
strchr(const char *s, char c)
{
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	8b 45 0c             	mov    0xc(%ebp),%eax
 231:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 234:	eb 14                	jmp    24a <strchr+0x22>
    if(*s == c)
 236:	8b 45 08             	mov    0x8(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 23f:	75 05                	jne    246 <strchr+0x1e>
      return (char*)s;
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	eb 13                	jmp    259 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 246:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	84 c0                	test   %al,%al
 252:	75 e2                	jne    236 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 254:	b8 00 00 00 00       	mov    $0x0,%eax
}
 259:	c9                   	leave  
 25a:	c3                   	ret    

0000025b <gets>:

char*
gets(char *buf, int max)
{
 25b:	55                   	push   %ebp
 25c:	89 e5                	mov    %esp,%ebp
 25e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 261:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 268:	eb 42                	jmp    2ac <gets+0x51>
    cc = read(0, &c, 1);
 26a:	83 ec 04             	sub    $0x4,%esp
 26d:	6a 01                	push   $0x1
 26f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 272:	50                   	push   %eax
 273:	6a 00                	push   $0x0
 275:	e8 e1 02 00 00       	call   55b <read>
 27a:	83 c4 10             	add    $0x10,%esp
 27d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 284:	7e 33                	jle    2b9 <gets+0x5e>
      break;
    buf[i++] = c;
 286:	8b 45 f4             	mov    -0xc(%ebp),%eax
 289:	8d 50 01             	lea    0x1(%eax),%edx
 28c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 28f:	89 c2                	mov    %eax,%edx
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	01 c2                	add    %eax,%edx
 296:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 29a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 29c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a0:	3c 0a                	cmp    $0xa,%al
 2a2:	74 16                	je     2ba <gets+0x5f>
 2a4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a8:	3c 0d                	cmp    $0xd,%al
 2aa:	74 0e                	je     2ba <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2af:	83 c0 01             	add    $0x1,%eax
 2b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2b5:	7c b3                	jl     26a <gets+0xf>
 2b7:	eb 01                	jmp    2ba <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 2b9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2bd:	8b 45 08             	mov    0x8(%ebp),%eax
 2c0:	01 d0                	add    %edx,%eax
 2c2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c8:	c9                   	leave  
 2c9:	c3                   	ret    

000002ca <stat>:

int
stat(char *n, struct stat *st)
{
 2ca:	55                   	push   %ebp
 2cb:	89 e5                	mov    %esp,%ebp
 2cd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	6a 00                	push   $0x0
 2d5:	ff 75 08             	pushl  0x8(%ebp)
 2d8:	e8 a6 02 00 00       	call   583 <open>
 2dd:	83 c4 10             	add    $0x10,%esp
 2e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2e7:	79 07                	jns    2f0 <stat+0x26>
    return -1;
 2e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ee:	eb 25                	jmp    315 <stat+0x4b>
  r = fstat(fd, st);
 2f0:	83 ec 08             	sub    $0x8,%esp
 2f3:	ff 75 0c             	pushl  0xc(%ebp)
 2f6:	ff 75 f4             	pushl  -0xc(%ebp)
 2f9:	e8 9d 02 00 00       	call   59b <fstat>
 2fe:	83 c4 10             	add    $0x10,%esp
 301:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 304:	83 ec 0c             	sub    $0xc,%esp
 307:	ff 75 f4             	pushl  -0xc(%ebp)
 30a:	e8 5c 02 00 00       	call   56b <close>
 30f:	83 c4 10             	add    $0x10,%esp
  return r;
 312:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 315:	c9                   	leave  
 316:	c3                   	ret    

00000317 <atoi>:

int
atoi(const char *s)
{
 317:	55                   	push   %ebp
 318:	89 e5                	mov    %esp,%ebp
 31a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 31d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 324:	eb 25                	jmp    34b <atoi+0x34>
    n = n*10 + *s++ - '0';
 326:	8b 55 fc             	mov    -0x4(%ebp),%edx
 329:	89 d0                	mov    %edx,%eax
 32b:	c1 e0 02             	shl    $0x2,%eax
 32e:	01 d0                	add    %edx,%eax
 330:	01 c0                	add    %eax,%eax
 332:	89 c1                	mov    %eax,%ecx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8d 50 01             	lea    0x1(%eax),%edx
 33a:	89 55 08             	mov    %edx,0x8(%ebp)
 33d:	0f b6 00             	movzbl (%eax),%eax
 340:	0f be c0             	movsbl %al,%eax
 343:	01 c8                	add    %ecx,%eax
 345:	83 e8 30             	sub    $0x30,%eax
 348:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
 34e:	0f b6 00             	movzbl (%eax),%eax
 351:	3c 2f                	cmp    $0x2f,%al
 353:	7e 0a                	jle    35f <atoi+0x48>
 355:	8b 45 08             	mov    0x8(%ebp),%eax
 358:	0f b6 00             	movzbl (%eax),%eax
 35b:	3c 39                	cmp    $0x39,%al
 35d:	7e c7                	jle    326 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 35f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 362:	c9                   	leave  
 363:	c3                   	ret    

00000364 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 36a:	8b 45 08             	mov    0x8(%ebp),%eax
 36d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 370:	8b 45 0c             	mov    0xc(%ebp),%eax
 373:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 376:	eb 17                	jmp    38f <memmove+0x2b>
    *dst++ = *src++;
 378:	8b 45 fc             	mov    -0x4(%ebp),%eax
 37b:	8d 50 01             	lea    0x1(%eax),%edx
 37e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 381:	8b 55 f8             	mov    -0x8(%ebp),%edx
 384:	8d 4a 01             	lea    0x1(%edx),%ecx
 387:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 38a:	0f b6 12             	movzbl (%edx),%edx
 38d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38f:	8b 45 10             	mov    0x10(%ebp),%eax
 392:	8d 50 ff             	lea    -0x1(%eax),%edx
 395:	89 55 10             	mov    %edx,0x10(%ebp)
 398:	85 c0                	test   %eax,%eax
 39a:	7f dc                	jg     378 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 39c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 39f:	c9                   	leave  
 3a0:	c3                   	ret    

000003a1 <historyAdd>:

void
historyAdd(char *buf1){
 3a1:	55                   	push   %ebp
 3a2:	89 e5                	mov    %esp,%ebp
 3a4:	53                   	push   %ebx
 3a5:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 3ab:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 3b2:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 3b9:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 3bf:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 3c3:	83 ec 08             	sub    $0x8,%esp
 3c6:	6a 00                	push   $0x0
 3c8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3cb:	50                   	push   %eax
 3cc:	e8 b2 01 00 00       	call   583 <open>
 3d1:	83 c4 10             	add    $0x10,%esp
 3d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 3d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3db:	79 1b                	jns    3f8 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 3dd:	83 ec 04             	sub    $0x4,%esp
 3e0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3e3:	50                   	push   %eax
 3e4:	68 94 0a 00 00       	push   $0xa94
 3e9:	6a 01                	push   $0x1
 3eb:	e8 ca 02 00 00       	call   6ba <printf>
 3f0:	83 c4 10             	add    $0x10,%esp
       exit();
 3f3:	e8 4b 01 00 00       	call   543 <exit>
     }

     int i=0;
 3f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 3ff:	eb 1c                	jmp    41d <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 401:	8b 55 f4             	mov    -0xc(%ebp),%edx
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	01 d0                	add    %edx,%eax
 409:	0f b6 00             	movzbl (%eax),%eax
 40c:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 412:	8b 55 f4             	mov    -0xc(%ebp),%edx
 415:	01 ca                	add    %ecx,%edx
 417:	88 02                	mov    %al,(%edx)
	i++;
 419:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 41d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 420:	8b 45 08             	mov    0x8(%ebp),%eax
 423:	01 d0                	add    %edx,%eax
 425:	0f b6 00             	movzbl (%eax),%eax
 428:	84 c0                	test   %al,%al
 42a:	75 d5                	jne    401 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 42c:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 432:	8b 45 f4             	mov    -0xc(%ebp),%eax
 435:	01 d0                	add    %edx,%eax
 437:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 43a:	eb 5a                	jmp    496 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 43c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 43f:	83 ec 0c             	sub    $0xc,%esp
 442:	ff 75 08             	pushl  0x8(%ebp)
 445:	e8 9d fd ff ff       	call   1e7 <strlen>
 44a:	83 c4 10             	add    $0x10,%esp
 44d:	29 c3                	sub    %eax,%ebx
 44f:	89 d8                	mov    %ebx,%eax
 451:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 458:	ff 
 459:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 45f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 462:	01 ca                	add    %ecx,%edx
 464:	88 02                	mov    %al,(%edx)
		i++;
 466:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 46a:	83 ec 0c             	sub    $0xc,%esp
 46d:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 473:	50                   	push   %eax
 474:	e8 6e fd ff ff       	call   1e7 <strlen>
 479:	83 c4 10             	add    $0x10,%esp
 47c:	89 c3                	mov    %eax,%ebx
 47e:	83 ec 0c             	sub    $0xc,%esp
 481:	ff 75 08             	pushl  0x8(%ebp)
 484:	e8 5e fd ff ff       	call   1e7 <strlen>
 489:	83 c4 10             	add    $0x10,%esp
 48c:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 48f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 492:	39 c2                	cmp    %eax,%edx
 494:	77 a6                	ja     43c <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 496:	83 ec 04             	sub    $0x4,%esp
 499:	68 e8 03 00 00       	push   $0x3e8
 49e:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 4a4:	50                   	push   %eax
 4a5:	ff 75 f0             	pushl  -0x10(%ebp)
 4a8:	e8 ae 00 00 00       	call   55b <read>
 4ad:	83 c4 10             	add    $0x10,%esp
 4b0:	85 c0                	test   %eax,%eax
 4b2:	7f b6                	jg     46a <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 4b4:	83 ec 0c             	sub    $0xc,%esp
 4b7:	ff 75 f0             	pushl  -0x10(%ebp)
 4ba:	e8 ac 00 00 00       	call   56b <close>
 4bf:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 4c2:	83 ec 08             	sub    $0x8,%esp
 4c5:	68 02 02 00 00       	push   $0x202
 4ca:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4cd:	50                   	push   %eax
 4ce:	e8 b0 00 00 00       	call   583 <open>
 4d3:	83 c4 10             	add    $0x10,%esp
 4d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 4d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4dd:	79 1b                	jns    4fa <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 4df:	83 ec 04             	sub    $0x4,%esp
 4e2:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4e5:	50                   	push   %eax
 4e6:	68 94 0a 00 00       	push   $0xa94
 4eb:	6a 01                	push   $0x1
 4ed:	e8 c8 01 00 00       	call   6ba <printf>
 4f2:	83 c4 10             	add    $0x10,%esp
       exit();
 4f5:	e8 49 00 00 00       	call   543 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 4fa:	83 ec 04             	sub    $0x4,%esp
 4fd:	68 e8 03 00 00       	push   $0x3e8
 502:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 508:	50                   	push   %eax
 509:	ff 75 f0             	pushl  -0x10(%ebp)
 50c:	e8 52 00 00 00       	call   563 <write>
 511:	83 c4 10             	add    $0x10,%esp
 514:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 519:	74 1a                	je     535 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 51b:	83 ec 04             	sub    $0x4,%esp
 51e:	ff 75 f4             	pushl  -0xc(%ebp)
 521:	68 b0 0a 00 00       	push   $0xab0
 526:	6a 01                	push   $0x1
 528:	e8 8d 01 00 00       	call   6ba <printf>
 52d:	83 c4 10             	add    $0x10,%esp
       exit();
 530:	e8 0e 00 00 00       	call   543 <exit>
     }
    
}
 535:	90                   	nop
 536:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 539:	c9                   	leave  
 53a:	c3                   	ret    

0000053b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 53b:	b8 01 00 00 00       	mov    $0x1,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <exit>:
SYSCALL(exit)
 543:	b8 02 00 00 00       	mov    $0x2,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <wait>:
SYSCALL(wait)
 54b:	b8 03 00 00 00       	mov    $0x3,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <pipe>:
SYSCALL(pipe)
 553:	b8 04 00 00 00       	mov    $0x4,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <read>:
SYSCALL(read)
 55b:	b8 05 00 00 00       	mov    $0x5,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <write>:
SYSCALL(write)
 563:	b8 10 00 00 00       	mov    $0x10,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <close>:
SYSCALL(close)
 56b:	b8 15 00 00 00       	mov    $0x15,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <kill>:
SYSCALL(kill)
 573:	b8 06 00 00 00       	mov    $0x6,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <exec>:
SYSCALL(exec)
 57b:	b8 07 00 00 00       	mov    $0x7,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <open>:
SYSCALL(open)
 583:	b8 0f 00 00 00       	mov    $0xf,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <mknod>:
SYSCALL(mknod)
 58b:	b8 11 00 00 00       	mov    $0x11,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <unlink>:
SYSCALL(unlink)
 593:	b8 12 00 00 00       	mov    $0x12,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <fstat>:
SYSCALL(fstat)
 59b:	b8 08 00 00 00       	mov    $0x8,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <link>:
SYSCALL(link)
 5a3:	b8 13 00 00 00       	mov    $0x13,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <mkdir>:
SYSCALL(mkdir)
 5ab:	b8 14 00 00 00       	mov    $0x14,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <chdir>:
SYSCALL(chdir)
 5b3:	b8 09 00 00 00       	mov    $0x9,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <dup>:
SYSCALL(dup)
 5bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <getpid>:
SYSCALL(getpid)
 5c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <sbrk>:
SYSCALL(sbrk)
 5cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <sleep>:
SYSCALL(sleep)
 5d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <uptime>:
SYSCALL(uptime)
 5db:	b8 0e 00 00 00       	mov    $0xe,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5e3:	55                   	push   %ebp
 5e4:	89 e5                	mov    %esp,%ebp
 5e6:	83 ec 18             	sub    $0x18,%esp
 5e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ec:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5ef:	83 ec 04             	sub    $0x4,%esp
 5f2:	6a 01                	push   $0x1
 5f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5f7:	50                   	push   %eax
 5f8:	ff 75 08             	pushl  0x8(%ebp)
 5fb:	e8 63 ff ff ff       	call   563 <write>
 600:	83 c4 10             	add    $0x10,%esp
}
 603:	90                   	nop
 604:	c9                   	leave  
 605:	c3                   	ret    

00000606 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 606:	55                   	push   %ebp
 607:	89 e5                	mov    %esp,%ebp
 609:	53                   	push   %ebx
 60a:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 60d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 614:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 618:	74 17                	je     631 <printint+0x2b>
 61a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 61e:	79 11                	jns    631 <printint+0x2b>
    neg = 1;
 620:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 627:	8b 45 0c             	mov    0xc(%ebp),%eax
 62a:	f7 d8                	neg    %eax
 62c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 62f:	eb 06                	jmp    637 <printint+0x31>
  } else {
    x = xx;
 631:	8b 45 0c             	mov    0xc(%ebp),%eax
 634:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 637:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 63e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 641:	8d 41 01             	lea    0x1(%ecx),%eax
 644:	89 45 f4             	mov    %eax,-0xc(%ebp)
 647:	8b 5d 10             	mov    0x10(%ebp),%ebx
 64a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 64d:	ba 00 00 00 00       	mov    $0x0,%edx
 652:	f7 f3                	div    %ebx
 654:	89 d0                	mov    %edx,%eax
 656:	0f b6 80 48 0d 00 00 	movzbl 0xd48(%eax),%eax
 65d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 661:	8b 5d 10             	mov    0x10(%ebp),%ebx
 664:	8b 45 ec             	mov    -0x14(%ebp),%eax
 667:	ba 00 00 00 00       	mov    $0x0,%edx
 66c:	f7 f3                	div    %ebx
 66e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 671:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 675:	75 c7                	jne    63e <printint+0x38>
  if(neg)
 677:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 67b:	74 2d                	je     6aa <printint+0xa4>
    buf[i++] = '-';
 67d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 680:	8d 50 01             	lea    0x1(%eax),%edx
 683:	89 55 f4             	mov    %edx,-0xc(%ebp)
 686:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 68b:	eb 1d                	jmp    6aa <printint+0xa4>
    putc(fd, buf[i]);
 68d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 690:	8b 45 f4             	mov    -0xc(%ebp),%eax
 693:	01 d0                	add    %edx,%eax
 695:	0f b6 00             	movzbl (%eax),%eax
 698:	0f be c0             	movsbl %al,%eax
 69b:	83 ec 08             	sub    $0x8,%esp
 69e:	50                   	push   %eax
 69f:	ff 75 08             	pushl  0x8(%ebp)
 6a2:	e8 3c ff ff ff       	call   5e3 <putc>
 6a7:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6aa:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 6ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6b2:	79 d9                	jns    68d <printint+0x87>
    putc(fd, buf[i]);
}
 6b4:	90                   	nop
 6b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6b8:	c9                   	leave  
 6b9:	c3                   	ret    

000006ba <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6ba:	55                   	push   %ebp
 6bb:	89 e5                	mov    %esp,%ebp
 6bd:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6c7:	8d 45 0c             	lea    0xc(%ebp),%eax
 6ca:	83 c0 04             	add    $0x4,%eax
 6cd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6d0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6d7:	e9 59 01 00 00       	jmp    835 <printf+0x17b>
    c = fmt[i] & 0xff;
 6dc:	8b 55 0c             	mov    0xc(%ebp),%edx
 6df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e2:	01 d0                	add    %edx,%eax
 6e4:	0f b6 00             	movzbl (%eax),%eax
 6e7:	0f be c0             	movsbl %al,%eax
 6ea:	25 ff 00 00 00       	and    $0xff,%eax
 6ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6f2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6f6:	75 2c                	jne    724 <printf+0x6a>
      if(c == '%'){
 6f8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6fc:	75 0c                	jne    70a <printf+0x50>
        state = '%';
 6fe:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 705:	e9 27 01 00 00       	jmp    831 <printf+0x177>
      } else {
        putc(fd, c);
 70a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 70d:	0f be c0             	movsbl %al,%eax
 710:	83 ec 08             	sub    $0x8,%esp
 713:	50                   	push   %eax
 714:	ff 75 08             	pushl  0x8(%ebp)
 717:	e8 c7 fe ff ff       	call   5e3 <putc>
 71c:	83 c4 10             	add    $0x10,%esp
 71f:	e9 0d 01 00 00       	jmp    831 <printf+0x177>
      }
    } else if(state == '%'){
 724:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 728:	0f 85 03 01 00 00    	jne    831 <printf+0x177>
      if(c == 'd'){
 72e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 732:	75 1e                	jne    752 <printf+0x98>
        printint(fd, *ap, 10, 1);
 734:	8b 45 e8             	mov    -0x18(%ebp),%eax
 737:	8b 00                	mov    (%eax),%eax
 739:	6a 01                	push   $0x1
 73b:	6a 0a                	push   $0xa
 73d:	50                   	push   %eax
 73e:	ff 75 08             	pushl  0x8(%ebp)
 741:	e8 c0 fe ff ff       	call   606 <printint>
 746:	83 c4 10             	add    $0x10,%esp
        ap++;
 749:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 74d:	e9 d8 00 00 00       	jmp    82a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 752:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 756:	74 06                	je     75e <printf+0xa4>
 758:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 75c:	75 1e                	jne    77c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 75e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 761:	8b 00                	mov    (%eax),%eax
 763:	6a 00                	push   $0x0
 765:	6a 10                	push   $0x10
 767:	50                   	push   %eax
 768:	ff 75 08             	pushl  0x8(%ebp)
 76b:	e8 96 fe ff ff       	call   606 <printint>
 770:	83 c4 10             	add    $0x10,%esp
        ap++;
 773:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 777:	e9 ae 00 00 00       	jmp    82a <printf+0x170>
      } else if(c == 's'){
 77c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 780:	75 43                	jne    7c5 <printf+0x10b>
        s = (char*)*ap;
 782:	8b 45 e8             	mov    -0x18(%ebp),%eax
 785:	8b 00                	mov    (%eax),%eax
 787:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 78a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 78e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 792:	75 25                	jne    7b9 <printf+0xff>
          s = "(null)";
 794:	c7 45 f4 d4 0a 00 00 	movl   $0xad4,-0xc(%ebp)
        while(*s != 0){
 79b:	eb 1c                	jmp    7b9 <printf+0xff>
          putc(fd, *s);
 79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a0:	0f b6 00             	movzbl (%eax),%eax
 7a3:	0f be c0             	movsbl %al,%eax
 7a6:	83 ec 08             	sub    $0x8,%esp
 7a9:	50                   	push   %eax
 7aa:	ff 75 08             	pushl  0x8(%ebp)
 7ad:	e8 31 fe ff ff       	call   5e3 <putc>
 7b2:	83 c4 10             	add    $0x10,%esp
          s++;
 7b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bc:	0f b6 00             	movzbl (%eax),%eax
 7bf:	84 c0                	test   %al,%al
 7c1:	75 da                	jne    79d <printf+0xe3>
 7c3:	eb 65                	jmp    82a <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7c5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7c9:	75 1d                	jne    7e8 <printf+0x12e>
        putc(fd, *ap);
 7cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ce:	8b 00                	mov    (%eax),%eax
 7d0:	0f be c0             	movsbl %al,%eax
 7d3:	83 ec 08             	sub    $0x8,%esp
 7d6:	50                   	push   %eax
 7d7:	ff 75 08             	pushl  0x8(%ebp)
 7da:	e8 04 fe ff ff       	call   5e3 <putc>
 7df:	83 c4 10             	add    $0x10,%esp
        ap++;
 7e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7e6:	eb 42                	jmp    82a <printf+0x170>
      } else if(c == '%'){
 7e8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ec:	75 17                	jne    805 <printf+0x14b>
        putc(fd, c);
 7ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7f1:	0f be c0             	movsbl %al,%eax
 7f4:	83 ec 08             	sub    $0x8,%esp
 7f7:	50                   	push   %eax
 7f8:	ff 75 08             	pushl  0x8(%ebp)
 7fb:	e8 e3 fd ff ff       	call   5e3 <putc>
 800:	83 c4 10             	add    $0x10,%esp
 803:	eb 25                	jmp    82a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 805:	83 ec 08             	sub    $0x8,%esp
 808:	6a 25                	push   $0x25
 80a:	ff 75 08             	pushl  0x8(%ebp)
 80d:	e8 d1 fd ff ff       	call   5e3 <putc>
 812:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 815:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 818:	0f be c0             	movsbl %al,%eax
 81b:	83 ec 08             	sub    $0x8,%esp
 81e:	50                   	push   %eax
 81f:	ff 75 08             	pushl  0x8(%ebp)
 822:	e8 bc fd ff ff       	call   5e3 <putc>
 827:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 82a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 831:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 835:	8b 55 0c             	mov    0xc(%ebp),%edx
 838:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83b:	01 d0                	add    %edx,%eax
 83d:	0f b6 00             	movzbl (%eax),%eax
 840:	84 c0                	test   %al,%al
 842:	0f 85 94 fe ff ff    	jne    6dc <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 848:	90                   	nop
 849:	c9                   	leave  
 84a:	c3                   	ret    

0000084b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 84b:	55                   	push   %ebp
 84c:	89 e5                	mov    %esp,%ebp
 84e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 851:	8b 45 08             	mov    0x8(%ebp),%eax
 854:	83 e8 08             	sub    $0x8,%eax
 857:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85a:	a1 64 0d 00 00       	mov    0xd64,%eax
 85f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 862:	eb 24                	jmp    888 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 864:	8b 45 fc             	mov    -0x4(%ebp),%eax
 867:	8b 00                	mov    (%eax),%eax
 869:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 86c:	77 12                	ja     880 <free+0x35>
 86e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 871:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 874:	77 24                	ja     89a <free+0x4f>
 876:	8b 45 fc             	mov    -0x4(%ebp),%eax
 879:	8b 00                	mov    (%eax),%eax
 87b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 87e:	77 1a                	ja     89a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 880:	8b 45 fc             	mov    -0x4(%ebp),%eax
 883:	8b 00                	mov    (%eax),%eax
 885:	89 45 fc             	mov    %eax,-0x4(%ebp)
 888:	8b 45 f8             	mov    -0x8(%ebp),%eax
 88b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 88e:	76 d4                	jbe    864 <free+0x19>
 890:	8b 45 fc             	mov    -0x4(%ebp),%eax
 893:	8b 00                	mov    (%eax),%eax
 895:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 898:	76 ca                	jbe    864 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 89a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89d:	8b 40 04             	mov    0x4(%eax),%eax
 8a0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8aa:	01 c2                	add    %eax,%edx
 8ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8af:	8b 00                	mov    (%eax),%eax
 8b1:	39 c2                	cmp    %eax,%edx
 8b3:	75 24                	jne    8d9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b8:	8b 50 04             	mov    0x4(%eax),%edx
 8bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8be:	8b 00                	mov    (%eax),%eax
 8c0:	8b 40 04             	mov    0x4(%eax),%eax
 8c3:	01 c2                	add    %eax,%edx
 8c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c8:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ce:	8b 00                	mov    (%eax),%eax
 8d0:	8b 10                	mov    (%eax),%edx
 8d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d5:	89 10                	mov    %edx,(%eax)
 8d7:	eb 0a                	jmp    8e3 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8dc:	8b 10                	mov    (%eax),%edx
 8de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e1:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e6:	8b 40 04             	mov    0x4(%eax),%eax
 8e9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f3:	01 d0                	add    %edx,%eax
 8f5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8f8:	75 20                	jne    91a <free+0xcf>
    p->s.size += bp->s.size;
 8fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fd:	8b 50 04             	mov    0x4(%eax),%edx
 900:	8b 45 f8             	mov    -0x8(%ebp),%eax
 903:	8b 40 04             	mov    0x4(%eax),%eax
 906:	01 c2                	add    %eax,%edx
 908:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 90e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 911:	8b 10                	mov    (%eax),%edx
 913:	8b 45 fc             	mov    -0x4(%ebp),%eax
 916:	89 10                	mov    %edx,(%eax)
 918:	eb 08                	jmp    922 <free+0xd7>
  } else
    p->s.ptr = bp;
 91a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 920:	89 10                	mov    %edx,(%eax)
  freep = p;
 922:	8b 45 fc             	mov    -0x4(%ebp),%eax
 925:	a3 64 0d 00 00       	mov    %eax,0xd64
}
 92a:	90                   	nop
 92b:	c9                   	leave  
 92c:	c3                   	ret    

0000092d <morecore>:

static Header*
morecore(uint nu)
{
 92d:	55                   	push   %ebp
 92e:	89 e5                	mov    %esp,%ebp
 930:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 933:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 93a:	77 07                	ja     943 <morecore+0x16>
    nu = 4096;
 93c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 943:	8b 45 08             	mov    0x8(%ebp),%eax
 946:	c1 e0 03             	shl    $0x3,%eax
 949:	83 ec 0c             	sub    $0xc,%esp
 94c:	50                   	push   %eax
 94d:	e8 79 fc ff ff       	call   5cb <sbrk>
 952:	83 c4 10             	add    $0x10,%esp
 955:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 958:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 95c:	75 07                	jne    965 <morecore+0x38>
    return 0;
 95e:	b8 00 00 00 00       	mov    $0x0,%eax
 963:	eb 26                	jmp    98b <morecore+0x5e>
  hp = (Header*)p;
 965:	8b 45 f4             	mov    -0xc(%ebp),%eax
 968:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 96b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 96e:	8b 55 08             	mov    0x8(%ebp),%edx
 971:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 974:	8b 45 f0             	mov    -0x10(%ebp),%eax
 977:	83 c0 08             	add    $0x8,%eax
 97a:	83 ec 0c             	sub    $0xc,%esp
 97d:	50                   	push   %eax
 97e:	e8 c8 fe ff ff       	call   84b <free>
 983:	83 c4 10             	add    $0x10,%esp
  return freep;
 986:	a1 64 0d 00 00       	mov    0xd64,%eax
}
 98b:	c9                   	leave  
 98c:	c3                   	ret    

0000098d <malloc>:

void*
malloc(uint nbytes)
{
 98d:	55                   	push   %ebp
 98e:	89 e5                	mov    %esp,%ebp
 990:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	83 c0 07             	add    $0x7,%eax
 999:	c1 e8 03             	shr    $0x3,%eax
 99c:	83 c0 01             	add    $0x1,%eax
 99f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9a2:	a1 64 0d 00 00       	mov    0xd64,%eax
 9a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9ae:	75 23                	jne    9d3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9b0:	c7 45 f0 5c 0d 00 00 	movl   $0xd5c,-0x10(%ebp)
 9b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ba:	a3 64 0d 00 00       	mov    %eax,0xd64
 9bf:	a1 64 0d 00 00       	mov    0xd64,%eax
 9c4:	a3 5c 0d 00 00       	mov    %eax,0xd5c
    base.s.size = 0;
 9c9:	c7 05 60 0d 00 00 00 	movl   $0x0,0xd60
 9d0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d6:	8b 00                	mov    (%eax),%eax
 9d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9de:	8b 40 04             	mov    0x4(%eax),%eax
 9e1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9e4:	72 4d                	jb     a33 <malloc+0xa6>
      if(p->s.size == nunits)
 9e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e9:	8b 40 04             	mov    0x4(%eax),%eax
 9ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9ef:	75 0c                	jne    9fd <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f4:	8b 10                	mov    (%eax),%edx
 9f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f9:	89 10                	mov    %edx,(%eax)
 9fb:	eb 26                	jmp    a23 <malloc+0x96>
      else {
        p->s.size -= nunits;
 9fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a00:	8b 40 04             	mov    0x4(%eax),%eax
 a03:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a06:	89 c2                	mov    %eax,%edx
 a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a11:	8b 40 04             	mov    0x4(%eax),%eax
 a14:	c1 e0 03             	shl    $0x3,%eax
 a17:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a20:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a26:	a3 64 0d 00 00       	mov    %eax,0xd64
      return (void*)(p + 1);
 a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2e:	83 c0 08             	add    $0x8,%eax
 a31:	eb 3b                	jmp    a6e <malloc+0xe1>
    }
    if(p == freep)
 a33:	a1 64 0d 00 00       	mov    0xd64,%eax
 a38:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a3b:	75 1e                	jne    a5b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a3d:	83 ec 0c             	sub    $0xc,%esp
 a40:	ff 75 ec             	pushl  -0x14(%ebp)
 a43:	e8 e5 fe ff ff       	call   92d <morecore>
 a48:	83 c4 10             	add    $0x10,%esp
 a4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a52:	75 07                	jne    a5b <malloc+0xce>
        return 0;
 a54:	b8 00 00 00 00       	mov    $0x0,%eax
 a59:	eb 13                	jmp    a6e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	8b 00                	mov    (%eax),%eax
 a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a69:	e9 6d ff ff ff       	jmp    9db <malloc+0x4e>
}
 a6e:	c9                   	leave  
 a6f:	c3                   	ret    
