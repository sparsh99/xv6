
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 90 09 00 00       	push   $0x990
  21:	6a 02                	push   $0x2
  23:	e8 b2 05 00 00       	call   5da <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 33 04 00 00       	call   463 <exit>
  }
  for(i=1; i<argc; i++)
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 2d                	jmp    66 <main+0x66>
    kill(atoi(argv[i]));
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 e4 01 00 00       	call   237 <atoi>
  53:	83 c4 10             	add    $0x10,%esp
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	50                   	push   %eax
  5a:	e8 34 04 00 00       	call   493 <kill>
  5f:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  69:	3b 03                	cmp    (%ebx),%eax
  6b:	7c cc                	jl     39 <main+0x39>
    kill(atoi(argv[i]));
  exit();
  6d:	e8 f1 03 00 00       	call   463 <exit>

00000072 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  72:	55                   	push   %ebp
  73:	89 e5                	mov    %esp,%ebp
  75:	57                   	push   %edi
  76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  77:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7a:	8b 55 10             	mov    0x10(%ebp),%edx
  7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  80:	89 cb                	mov    %ecx,%ebx
  82:	89 df                	mov    %ebx,%edi
  84:	89 d1                	mov    %edx,%ecx
  86:	fc                   	cld    
  87:	f3 aa                	rep stos %al,%es:(%edi)
  89:	89 ca                	mov    %ecx,%edx
  8b:	89 fb                	mov    %edi,%ebx
  8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
  90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  93:	90                   	nop
  94:	5b                   	pop    %ebx
  95:	5f                   	pop    %edi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    

00000098 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  98:	55                   	push   %ebp
  99:	89 e5                	mov    %esp,%ebp
  9b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9e:	8b 45 08             	mov    0x8(%ebp),%eax
  a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a4:	90                   	nop
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	8d 50 01             	lea    0x1(%eax),%edx
  ab:	89 55 08             	mov    %edx,0x8(%ebp)
  ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  b1:	8d 4a 01             	lea    0x1(%edx),%ecx
  b4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b7:	0f b6 12             	movzbl (%edx),%edx
  ba:	88 10                	mov    %dl,(%eax)
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	84 c0                	test   %al,%al
  c1:	75 e2                	jne    a5 <strcpy+0xd>
    ;
  return os;
  c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c6:	c9                   	leave  
  c7:	c3                   	ret    

000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cb:	eb 08                	jmp    d5 <strcmp+0xd>
    p++, q++;
  cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	84 c0                	test   %al,%al
  dd:	74 10                	je     ef <strcmp+0x27>
  df:	8b 45 08             	mov    0x8(%ebp),%eax
  e2:	0f b6 10             	movzbl (%eax),%edx
  e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  e8:	0f b6 00             	movzbl (%eax),%eax
  eb:	38 c2                	cmp    %al,%dl
  ed:	74 de                	je     cd <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ef:	8b 45 08             	mov    0x8(%ebp),%eax
  f2:	0f b6 00             	movzbl (%eax),%eax
  f5:	0f b6 d0             	movzbl %al,%edx
  f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  fb:	0f b6 00             	movzbl (%eax),%eax
  fe:	0f b6 c0             	movzbl %al,%eax
 101:	29 c2                	sub    %eax,%edx
 103:	89 d0                	mov    %edx,%eax
}
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    

00000107 <strlen>:

uint
strlen(char *s)
{
 107:	55                   	push   %ebp
 108:	89 e5                	mov    %esp,%ebp
 10a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 114:	eb 04                	jmp    11a <strlen+0x13>
 116:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11d:	8b 45 08             	mov    0x8(%ebp),%eax
 120:	01 d0                	add    %edx,%eax
 122:	0f b6 00             	movzbl (%eax),%eax
 125:	84 c0                	test   %al,%al
 127:	75 ed                	jne    116 <strlen+0xf>
    ;
  return n;
 129:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12c:	c9                   	leave  
 12d:	c3                   	ret    

0000012e <memset>:

void*
memset(void *dst, int c, uint n)
{
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 131:	8b 45 10             	mov    0x10(%ebp),%eax
 134:	50                   	push   %eax
 135:	ff 75 0c             	pushl  0xc(%ebp)
 138:	ff 75 08             	pushl  0x8(%ebp)
 13b:	e8 32 ff ff ff       	call   72 <stosb>
 140:	83 c4 0c             	add    $0xc,%esp
  return dst;
 143:	8b 45 08             	mov    0x8(%ebp),%eax
}
 146:	c9                   	leave  
 147:	c3                   	ret    

00000148 <strchr>:

char*
strchr(const char *s, char c)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	83 ec 04             	sub    $0x4,%esp
 14e:	8b 45 0c             	mov    0xc(%ebp),%eax
 151:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 154:	eb 14                	jmp    16a <strchr+0x22>
    if(*s == c)
 156:	8b 45 08             	mov    0x8(%ebp),%eax
 159:	0f b6 00             	movzbl (%eax),%eax
 15c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15f:	75 05                	jne    166 <strchr+0x1e>
      return (char*)s;
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	eb 13                	jmp    179 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 166:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
 16d:	0f b6 00             	movzbl (%eax),%eax
 170:	84 c0                	test   %al,%al
 172:	75 e2                	jne    156 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 174:	b8 00 00 00 00       	mov    $0x0,%eax
}
 179:	c9                   	leave  
 17a:	c3                   	ret    

0000017b <gets>:

char*
gets(char *buf, int max)
{
 17b:	55                   	push   %ebp
 17c:	89 e5                	mov    %esp,%ebp
 17e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 181:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 188:	eb 42                	jmp    1cc <gets+0x51>
    cc = read(0, &c, 1);
 18a:	83 ec 04             	sub    $0x4,%esp
 18d:	6a 01                	push   $0x1
 18f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 192:	50                   	push   %eax
 193:	6a 00                	push   $0x0
 195:	e8 e1 02 00 00       	call   47b <read>
 19a:	83 c4 10             	add    $0x10,%esp
 19d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a4:	7e 33                	jle    1d9 <gets+0x5e>
      break;
    buf[i++] = c;
 1a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a9:	8d 50 01             	lea    0x1(%eax),%edx
 1ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1af:	89 c2                	mov    %eax,%edx
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	01 c2                	add    %eax,%edx
 1b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ba:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c0:	3c 0a                	cmp    $0xa,%al
 1c2:	74 16                	je     1da <gets+0x5f>
 1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c8:	3c 0d                	cmp    $0xd,%al
 1ca:	74 0e                	je     1da <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1cf:	83 c0 01             	add    $0x1,%eax
 1d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d5:	7c b3                	jl     18a <gets+0xf>
 1d7:	eb 01                	jmp    1da <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1d9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1da:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	01 d0                	add    %edx,%eax
 1e2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e8:	c9                   	leave  
 1e9:	c3                   	ret    

000001ea <stat>:

int
stat(char *n, struct stat *st)
{
 1ea:	55                   	push   %ebp
 1eb:	89 e5                	mov    %esp,%ebp
 1ed:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f0:	83 ec 08             	sub    $0x8,%esp
 1f3:	6a 00                	push   $0x0
 1f5:	ff 75 08             	pushl  0x8(%ebp)
 1f8:	e8 a6 02 00 00       	call   4a3 <open>
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 203:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 207:	79 07                	jns    210 <stat+0x26>
    return -1;
 209:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 20e:	eb 25                	jmp    235 <stat+0x4b>
  r = fstat(fd, st);
 210:	83 ec 08             	sub    $0x8,%esp
 213:	ff 75 0c             	pushl  0xc(%ebp)
 216:	ff 75 f4             	pushl  -0xc(%ebp)
 219:	e8 9d 02 00 00       	call   4bb <fstat>
 21e:	83 c4 10             	add    $0x10,%esp
 221:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 224:	83 ec 0c             	sub    $0xc,%esp
 227:	ff 75 f4             	pushl  -0xc(%ebp)
 22a:	e8 5c 02 00 00       	call   48b <close>
 22f:	83 c4 10             	add    $0x10,%esp
  return r;
 232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 235:	c9                   	leave  
 236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
 237:	55                   	push   %ebp
 238:	89 e5                	mov    %esp,%ebp
 23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 244:	eb 25                	jmp    26b <atoi+0x34>
    n = n*10 + *s++ - '0';
 246:	8b 55 fc             	mov    -0x4(%ebp),%edx
 249:	89 d0                	mov    %edx,%eax
 24b:	c1 e0 02             	shl    $0x2,%eax
 24e:	01 d0                	add    %edx,%eax
 250:	01 c0                	add    %eax,%eax
 252:	89 c1                	mov    %eax,%ecx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8d 50 01             	lea    0x1(%eax),%edx
 25a:	89 55 08             	mov    %edx,0x8(%ebp)
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	0f be c0             	movsbl %al,%eax
 263:	01 c8                	add    %ecx,%eax
 265:	83 e8 30             	sub    $0x30,%eax
 268:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	3c 2f                	cmp    $0x2f,%al
 273:	7e 0a                	jle    27f <atoi+0x48>
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	0f b6 00             	movzbl (%eax),%eax
 27b:	3c 39                	cmp    $0x39,%al
 27d:	7e c7                	jle    246 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 282:	c9                   	leave  
 283:	c3                   	ret    

00000284 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 290:	8b 45 0c             	mov    0xc(%ebp),%eax
 293:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 296:	eb 17                	jmp    2af <memmove+0x2b>
    *dst++ = *src++;
 298:	8b 45 fc             	mov    -0x4(%ebp),%eax
 29b:	8d 50 01             	lea    0x1(%eax),%edx
 29e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a4:	8d 4a 01             	lea    0x1(%edx),%ecx
 2a7:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2aa:	0f b6 12             	movzbl (%edx),%edx
 2ad:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2af:	8b 45 10             	mov    0x10(%ebp),%eax
 2b2:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b5:	89 55 10             	mov    %edx,0x10(%ebp)
 2b8:	85 c0                	test   %eax,%eax
 2ba:	7f dc                	jg     298 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bf:	c9                   	leave  
 2c0:	c3                   	ret    

000002c1 <historyAdd>:

void
historyAdd(char *buf1){
 2c1:	55                   	push   %ebp
 2c2:	89 e5                	mov    %esp,%ebp
 2c4:	53                   	push   %ebx
 2c5:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 2cb:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 2d2:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 2d9:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 2df:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 2e3:	83 ec 08             	sub    $0x8,%esp
 2e6:	6a 00                	push   $0x0
 2e8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 2eb:	50                   	push   %eax
 2ec:	e8 b2 01 00 00       	call   4a3 <open>
 2f1:	83 c4 10             	add    $0x10,%esp
 2f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2fb:	79 1b                	jns    318 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 2fd:	83 ec 04             	sub    $0x4,%esp
 300:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 303:	50                   	push   %eax
 304:	68 a4 09 00 00       	push   $0x9a4
 309:	6a 01                	push   $0x1
 30b:	e8 ca 02 00 00       	call   5da <printf>
 310:	83 c4 10             	add    $0x10,%esp
       exit();
 313:	e8 4b 01 00 00       	call   463 <exit>
     }

     int i=0;
 318:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 31f:	eb 1c                	jmp    33d <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 321:	8b 55 f4             	mov    -0xc(%ebp),%edx
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	01 d0                	add    %edx,%eax
 329:	0f b6 00             	movzbl (%eax),%eax
 32c:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 332:	8b 55 f4             	mov    -0xc(%ebp),%edx
 335:	01 ca                	add    %ecx,%edx
 337:	88 02                	mov    %al,(%edx)
	i++;
 339:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 33d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 340:	8b 45 08             	mov    0x8(%ebp),%eax
 343:	01 d0                	add    %edx,%eax
 345:	0f b6 00             	movzbl (%eax),%eax
 348:	84 c0                	test   %al,%al
 34a:	75 d5                	jne    321 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 34c:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 352:	8b 45 f4             	mov    -0xc(%ebp),%eax
 355:	01 d0                	add    %edx,%eax
 357:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 35a:	eb 5a                	jmp    3b6 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 35c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 35f:	83 ec 0c             	sub    $0xc,%esp
 362:	ff 75 08             	pushl  0x8(%ebp)
 365:	e8 9d fd ff ff       	call   107 <strlen>
 36a:	83 c4 10             	add    $0x10,%esp
 36d:	29 c3                	sub    %eax,%ebx
 36f:	89 d8                	mov    %ebx,%eax
 371:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 378:	ff 
 379:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 37f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 382:	01 ca                	add    %ecx,%edx
 384:	88 02                	mov    %al,(%edx)
		i++;
 386:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 38a:	83 ec 0c             	sub    $0xc,%esp
 38d:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 393:	50                   	push   %eax
 394:	e8 6e fd ff ff       	call   107 <strlen>
 399:	83 c4 10             	add    $0x10,%esp
 39c:	89 c3                	mov    %eax,%ebx
 39e:	83 ec 0c             	sub    $0xc,%esp
 3a1:	ff 75 08             	pushl  0x8(%ebp)
 3a4:	e8 5e fd ff ff       	call   107 <strlen>
 3a9:	83 c4 10             	add    $0x10,%esp
 3ac:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 3af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3b2:	39 c2                	cmp    %eax,%edx
 3b4:	77 a6                	ja     35c <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3b6:	83 ec 04             	sub    $0x4,%esp
 3b9:	68 e8 03 00 00       	push   $0x3e8
 3be:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 3c4:	50                   	push   %eax
 3c5:	ff 75 f0             	pushl  -0x10(%ebp)
 3c8:	e8 ae 00 00 00       	call   47b <read>
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	85 c0                	test   %eax,%eax
 3d2:	7f b6                	jg     38a <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 3d4:	83 ec 0c             	sub    $0xc,%esp
 3d7:	ff 75 f0             	pushl  -0x10(%ebp)
 3da:	e8 ac 00 00 00       	call   48b <close>
 3df:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 3e2:	83 ec 08             	sub    $0x8,%esp
 3e5:	68 02 02 00 00       	push   $0x202
 3ea:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3ed:	50                   	push   %eax
 3ee:	e8 b0 00 00 00       	call   4a3 <open>
 3f3:	83 c4 10             	add    $0x10,%esp
 3f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 3f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3fd:	79 1b                	jns    41a <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 3ff:	83 ec 04             	sub    $0x4,%esp
 402:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 405:	50                   	push   %eax
 406:	68 a4 09 00 00       	push   $0x9a4
 40b:	6a 01                	push   $0x1
 40d:	e8 c8 01 00 00       	call   5da <printf>
 412:	83 c4 10             	add    $0x10,%esp
       exit();
 415:	e8 49 00 00 00       	call   463 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 41a:	83 ec 04             	sub    $0x4,%esp
 41d:	68 e8 03 00 00       	push   $0x3e8
 422:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 428:	50                   	push   %eax
 429:	ff 75 f0             	pushl  -0x10(%ebp)
 42c:	e8 52 00 00 00       	call   483 <write>
 431:	83 c4 10             	add    $0x10,%esp
 434:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 439:	74 1a                	je     455 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 43b:	83 ec 04             	sub    $0x4,%esp
 43e:	ff 75 f4             	pushl  -0xc(%ebp)
 441:	68 c0 09 00 00       	push   $0x9c0
 446:	6a 01                	push   $0x1
 448:	e8 8d 01 00 00       	call   5da <printf>
 44d:	83 c4 10             	add    $0x10,%esp
       exit();
 450:	e8 0e 00 00 00       	call   463 <exit>
     }
    
}
 455:	90                   	nop
 456:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 459:	c9                   	leave  
 45a:	c3                   	ret    

0000045b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 45b:	b8 01 00 00 00       	mov    $0x1,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <exit>:
SYSCALL(exit)
 463:	b8 02 00 00 00       	mov    $0x2,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <wait>:
SYSCALL(wait)
 46b:	b8 03 00 00 00       	mov    $0x3,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <pipe>:
SYSCALL(pipe)
 473:	b8 04 00 00 00       	mov    $0x4,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <read>:
SYSCALL(read)
 47b:	b8 05 00 00 00       	mov    $0x5,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <write>:
SYSCALL(write)
 483:	b8 10 00 00 00       	mov    $0x10,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <close>:
SYSCALL(close)
 48b:	b8 15 00 00 00       	mov    $0x15,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <kill>:
SYSCALL(kill)
 493:	b8 06 00 00 00       	mov    $0x6,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <exec>:
SYSCALL(exec)
 49b:	b8 07 00 00 00       	mov    $0x7,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <open>:
SYSCALL(open)
 4a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <mknod>:
SYSCALL(mknod)
 4ab:	b8 11 00 00 00       	mov    $0x11,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <unlink>:
SYSCALL(unlink)
 4b3:	b8 12 00 00 00       	mov    $0x12,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <fstat>:
SYSCALL(fstat)
 4bb:	b8 08 00 00 00       	mov    $0x8,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <link>:
SYSCALL(link)
 4c3:	b8 13 00 00 00       	mov    $0x13,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <mkdir>:
SYSCALL(mkdir)
 4cb:	b8 14 00 00 00       	mov    $0x14,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <chdir>:
SYSCALL(chdir)
 4d3:	b8 09 00 00 00       	mov    $0x9,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <dup>:
SYSCALL(dup)
 4db:	b8 0a 00 00 00       	mov    $0xa,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <getpid>:
SYSCALL(getpid)
 4e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <sbrk>:
SYSCALL(sbrk)
 4eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <sleep>:
SYSCALL(sleep)
 4f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <uptime>:
SYSCALL(uptime)
 4fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 503:	55                   	push   %ebp
 504:	89 e5                	mov    %esp,%ebp
 506:	83 ec 18             	sub    $0x18,%esp
 509:	8b 45 0c             	mov    0xc(%ebp),%eax
 50c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 50f:	83 ec 04             	sub    $0x4,%esp
 512:	6a 01                	push   $0x1
 514:	8d 45 f4             	lea    -0xc(%ebp),%eax
 517:	50                   	push   %eax
 518:	ff 75 08             	pushl  0x8(%ebp)
 51b:	e8 63 ff ff ff       	call   483 <write>
 520:	83 c4 10             	add    $0x10,%esp
}
 523:	90                   	nop
 524:	c9                   	leave  
 525:	c3                   	ret    

00000526 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 526:	55                   	push   %ebp
 527:	89 e5                	mov    %esp,%ebp
 529:	53                   	push   %ebx
 52a:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 52d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 534:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 538:	74 17                	je     551 <printint+0x2b>
 53a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 53e:	79 11                	jns    551 <printint+0x2b>
    neg = 1;
 540:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 547:	8b 45 0c             	mov    0xc(%ebp),%eax
 54a:	f7 d8                	neg    %eax
 54c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 54f:	eb 06                	jmp    557 <printint+0x31>
  } else {
    x = xx;
 551:	8b 45 0c             	mov    0xc(%ebp),%eax
 554:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 557:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 55e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 561:	8d 41 01             	lea    0x1(%ecx),%eax
 564:	89 45 f4             	mov    %eax,-0xc(%ebp)
 567:	8b 5d 10             	mov    0x10(%ebp),%ebx
 56a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 56d:	ba 00 00 00 00       	mov    $0x0,%edx
 572:	f7 f3                	div    %ebx
 574:	89 d0                	mov    %edx,%eax
 576:	0f b6 80 5c 0c 00 00 	movzbl 0xc5c(%eax),%eax
 57d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 581:	8b 5d 10             	mov    0x10(%ebp),%ebx
 584:	8b 45 ec             	mov    -0x14(%ebp),%eax
 587:	ba 00 00 00 00       	mov    $0x0,%edx
 58c:	f7 f3                	div    %ebx
 58e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 591:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 595:	75 c7                	jne    55e <printint+0x38>
  if(neg)
 597:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 59b:	74 2d                	je     5ca <printint+0xa4>
    buf[i++] = '-';
 59d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a0:	8d 50 01             	lea    0x1(%eax),%edx
 5a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5a6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5ab:	eb 1d                	jmp    5ca <printint+0xa4>
    putc(fd, buf[i]);
 5ad:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b3:	01 d0                	add    %edx,%eax
 5b5:	0f b6 00             	movzbl (%eax),%eax
 5b8:	0f be c0             	movsbl %al,%eax
 5bb:	83 ec 08             	sub    $0x8,%esp
 5be:	50                   	push   %eax
 5bf:	ff 75 08             	pushl  0x8(%ebp)
 5c2:	e8 3c ff ff ff       	call   503 <putc>
 5c7:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5ca:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d2:	79 d9                	jns    5ad <printint+0x87>
    putc(fd, buf[i]);
}
 5d4:	90                   	nop
 5d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5d8:	c9                   	leave  
 5d9:	c3                   	ret    

000005da <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5da:	55                   	push   %ebp
 5db:	89 e5                	mov    %esp,%ebp
 5dd:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5e0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5e7:	8d 45 0c             	lea    0xc(%ebp),%eax
 5ea:	83 c0 04             	add    $0x4,%eax
 5ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5f7:	e9 59 01 00 00       	jmp    755 <printf+0x17b>
    c = fmt[i] & 0xff;
 5fc:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 602:	01 d0                	add    %edx,%eax
 604:	0f b6 00             	movzbl (%eax),%eax
 607:	0f be c0             	movsbl %al,%eax
 60a:	25 ff 00 00 00       	and    $0xff,%eax
 60f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 612:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 616:	75 2c                	jne    644 <printf+0x6a>
      if(c == '%'){
 618:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 61c:	75 0c                	jne    62a <printf+0x50>
        state = '%';
 61e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 625:	e9 27 01 00 00       	jmp    751 <printf+0x177>
      } else {
        putc(fd, c);
 62a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62d:	0f be c0             	movsbl %al,%eax
 630:	83 ec 08             	sub    $0x8,%esp
 633:	50                   	push   %eax
 634:	ff 75 08             	pushl  0x8(%ebp)
 637:	e8 c7 fe ff ff       	call   503 <putc>
 63c:	83 c4 10             	add    $0x10,%esp
 63f:	e9 0d 01 00 00       	jmp    751 <printf+0x177>
      }
    } else if(state == '%'){
 644:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 648:	0f 85 03 01 00 00    	jne    751 <printf+0x177>
      if(c == 'd'){
 64e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 652:	75 1e                	jne    672 <printf+0x98>
        printint(fd, *ap, 10, 1);
 654:	8b 45 e8             	mov    -0x18(%ebp),%eax
 657:	8b 00                	mov    (%eax),%eax
 659:	6a 01                	push   $0x1
 65b:	6a 0a                	push   $0xa
 65d:	50                   	push   %eax
 65e:	ff 75 08             	pushl  0x8(%ebp)
 661:	e8 c0 fe ff ff       	call   526 <printint>
 666:	83 c4 10             	add    $0x10,%esp
        ap++;
 669:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 66d:	e9 d8 00 00 00       	jmp    74a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 672:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 676:	74 06                	je     67e <printf+0xa4>
 678:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 67c:	75 1e                	jne    69c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 67e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 681:	8b 00                	mov    (%eax),%eax
 683:	6a 00                	push   $0x0
 685:	6a 10                	push   $0x10
 687:	50                   	push   %eax
 688:	ff 75 08             	pushl  0x8(%ebp)
 68b:	e8 96 fe ff ff       	call   526 <printint>
 690:	83 c4 10             	add    $0x10,%esp
        ap++;
 693:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 697:	e9 ae 00 00 00       	jmp    74a <printf+0x170>
      } else if(c == 's'){
 69c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6a0:	75 43                	jne    6e5 <printf+0x10b>
        s = (char*)*ap;
 6a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a5:	8b 00                	mov    (%eax),%eax
 6a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6b2:	75 25                	jne    6d9 <printf+0xff>
          s = "(null)";
 6b4:	c7 45 f4 e4 09 00 00 	movl   $0x9e4,-0xc(%ebp)
        while(*s != 0){
 6bb:	eb 1c                	jmp    6d9 <printf+0xff>
          putc(fd, *s);
 6bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c0:	0f b6 00             	movzbl (%eax),%eax
 6c3:	0f be c0             	movsbl %al,%eax
 6c6:	83 ec 08             	sub    $0x8,%esp
 6c9:	50                   	push   %eax
 6ca:	ff 75 08             	pushl  0x8(%ebp)
 6cd:	e8 31 fe ff ff       	call   503 <putc>
 6d2:	83 c4 10             	add    $0x10,%esp
          s++;
 6d5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6dc:	0f b6 00             	movzbl (%eax),%eax
 6df:	84 c0                	test   %al,%al
 6e1:	75 da                	jne    6bd <printf+0xe3>
 6e3:	eb 65                	jmp    74a <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6e9:	75 1d                	jne    708 <printf+0x12e>
        putc(fd, *ap);
 6eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ee:	8b 00                	mov    (%eax),%eax
 6f0:	0f be c0             	movsbl %al,%eax
 6f3:	83 ec 08             	sub    $0x8,%esp
 6f6:	50                   	push   %eax
 6f7:	ff 75 08             	pushl  0x8(%ebp)
 6fa:	e8 04 fe ff ff       	call   503 <putc>
 6ff:	83 c4 10             	add    $0x10,%esp
        ap++;
 702:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 706:	eb 42                	jmp    74a <printf+0x170>
      } else if(c == '%'){
 708:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 70c:	75 17                	jne    725 <printf+0x14b>
        putc(fd, c);
 70e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 711:	0f be c0             	movsbl %al,%eax
 714:	83 ec 08             	sub    $0x8,%esp
 717:	50                   	push   %eax
 718:	ff 75 08             	pushl  0x8(%ebp)
 71b:	e8 e3 fd ff ff       	call   503 <putc>
 720:	83 c4 10             	add    $0x10,%esp
 723:	eb 25                	jmp    74a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 725:	83 ec 08             	sub    $0x8,%esp
 728:	6a 25                	push   $0x25
 72a:	ff 75 08             	pushl  0x8(%ebp)
 72d:	e8 d1 fd ff ff       	call   503 <putc>
 732:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 735:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 738:	0f be c0             	movsbl %al,%eax
 73b:	83 ec 08             	sub    $0x8,%esp
 73e:	50                   	push   %eax
 73f:	ff 75 08             	pushl  0x8(%ebp)
 742:	e8 bc fd ff ff       	call   503 <putc>
 747:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 74a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 751:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 755:	8b 55 0c             	mov    0xc(%ebp),%edx
 758:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75b:	01 d0                	add    %edx,%eax
 75d:	0f b6 00             	movzbl (%eax),%eax
 760:	84 c0                	test   %al,%al
 762:	0f 85 94 fe ff ff    	jne    5fc <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 768:	90                   	nop
 769:	c9                   	leave  
 76a:	c3                   	ret    

0000076b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 76b:	55                   	push   %ebp
 76c:	89 e5                	mov    %esp,%ebp
 76e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 771:	8b 45 08             	mov    0x8(%ebp),%eax
 774:	83 e8 08             	sub    $0x8,%eax
 777:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77a:	a1 78 0c 00 00       	mov    0xc78,%eax
 77f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 782:	eb 24                	jmp    7a8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 784:	8b 45 fc             	mov    -0x4(%ebp),%eax
 787:	8b 00                	mov    (%eax),%eax
 789:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 78c:	77 12                	ja     7a0 <free+0x35>
 78e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 791:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 794:	77 24                	ja     7ba <free+0x4f>
 796:	8b 45 fc             	mov    -0x4(%ebp),%eax
 799:	8b 00                	mov    (%eax),%eax
 79b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 79e:	77 1a                	ja     7ba <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a3:	8b 00                	mov    (%eax),%eax
 7a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ae:	76 d4                	jbe    784 <free+0x19>
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	8b 00                	mov    (%eax),%eax
 7b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7b8:	76 ca                	jbe    784 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bd:	8b 40 04             	mov    0x4(%eax),%eax
 7c0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ca:	01 c2                	add    %eax,%edx
 7cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cf:	8b 00                	mov    (%eax),%eax
 7d1:	39 c2                	cmp    %eax,%edx
 7d3:	75 24                	jne    7f9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d8:	8b 50 04             	mov    0x4(%eax),%edx
 7db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7de:	8b 00                	mov    (%eax),%eax
 7e0:	8b 40 04             	mov    0x4(%eax),%eax
 7e3:	01 c2                	add    %eax,%edx
 7e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e8:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ee:	8b 00                	mov    (%eax),%eax
 7f0:	8b 10                	mov    (%eax),%edx
 7f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f5:	89 10                	mov    %edx,(%eax)
 7f7:	eb 0a                	jmp    803 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fc:	8b 10                	mov    (%eax),%edx
 7fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 801:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 803:	8b 45 fc             	mov    -0x4(%ebp),%eax
 806:	8b 40 04             	mov    0x4(%eax),%eax
 809:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 810:	8b 45 fc             	mov    -0x4(%ebp),%eax
 813:	01 d0                	add    %edx,%eax
 815:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 818:	75 20                	jne    83a <free+0xcf>
    p->s.size += bp->s.size;
 81a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81d:	8b 50 04             	mov    0x4(%eax),%edx
 820:	8b 45 f8             	mov    -0x8(%ebp),%eax
 823:	8b 40 04             	mov    0x4(%eax),%eax
 826:	01 c2                	add    %eax,%edx
 828:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 82e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 831:	8b 10                	mov    (%eax),%edx
 833:	8b 45 fc             	mov    -0x4(%ebp),%eax
 836:	89 10                	mov    %edx,(%eax)
 838:	eb 08                	jmp    842 <free+0xd7>
  } else
    p->s.ptr = bp;
 83a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 840:	89 10                	mov    %edx,(%eax)
  freep = p;
 842:	8b 45 fc             	mov    -0x4(%ebp),%eax
 845:	a3 78 0c 00 00       	mov    %eax,0xc78
}
 84a:	90                   	nop
 84b:	c9                   	leave  
 84c:	c3                   	ret    

0000084d <morecore>:

static Header*
morecore(uint nu)
{
 84d:	55                   	push   %ebp
 84e:	89 e5                	mov    %esp,%ebp
 850:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 853:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 85a:	77 07                	ja     863 <morecore+0x16>
    nu = 4096;
 85c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 863:	8b 45 08             	mov    0x8(%ebp),%eax
 866:	c1 e0 03             	shl    $0x3,%eax
 869:	83 ec 0c             	sub    $0xc,%esp
 86c:	50                   	push   %eax
 86d:	e8 79 fc ff ff       	call   4eb <sbrk>
 872:	83 c4 10             	add    $0x10,%esp
 875:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 878:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 87c:	75 07                	jne    885 <morecore+0x38>
    return 0;
 87e:	b8 00 00 00 00       	mov    $0x0,%eax
 883:	eb 26                	jmp    8ab <morecore+0x5e>
  hp = (Header*)p;
 885:	8b 45 f4             	mov    -0xc(%ebp),%eax
 888:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 88b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88e:	8b 55 08             	mov    0x8(%ebp),%edx
 891:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 894:	8b 45 f0             	mov    -0x10(%ebp),%eax
 897:	83 c0 08             	add    $0x8,%eax
 89a:	83 ec 0c             	sub    $0xc,%esp
 89d:	50                   	push   %eax
 89e:	e8 c8 fe ff ff       	call   76b <free>
 8a3:	83 c4 10             	add    $0x10,%esp
  return freep;
 8a6:	a1 78 0c 00 00       	mov    0xc78,%eax
}
 8ab:	c9                   	leave  
 8ac:	c3                   	ret    

000008ad <malloc>:

void*
malloc(uint nbytes)
{
 8ad:	55                   	push   %ebp
 8ae:	89 e5                	mov    %esp,%ebp
 8b0:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b3:	8b 45 08             	mov    0x8(%ebp),%eax
 8b6:	83 c0 07             	add    $0x7,%eax
 8b9:	c1 e8 03             	shr    $0x3,%eax
 8bc:	83 c0 01             	add    $0x1,%eax
 8bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8c2:	a1 78 0c 00 00       	mov    0xc78,%eax
 8c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8ce:	75 23                	jne    8f3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8d0:	c7 45 f0 70 0c 00 00 	movl   $0xc70,-0x10(%ebp)
 8d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8da:	a3 78 0c 00 00       	mov    %eax,0xc78
 8df:	a1 78 0c 00 00       	mov    0xc78,%eax
 8e4:	a3 70 0c 00 00       	mov    %eax,0xc70
    base.s.size = 0;
 8e9:	c7 05 74 0c 00 00 00 	movl   $0x0,0xc74
 8f0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f6:	8b 00                	mov    (%eax),%eax
 8f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fe:	8b 40 04             	mov    0x4(%eax),%eax
 901:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 904:	72 4d                	jb     953 <malloc+0xa6>
      if(p->s.size == nunits)
 906:	8b 45 f4             	mov    -0xc(%ebp),%eax
 909:	8b 40 04             	mov    0x4(%eax),%eax
 90c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 90f:	75 0c                	jne    91d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 911:	8b 45 f4             	mov    -0xc(%ebp),%eax
 914:	8b 10                	mov    (%eax),%edx
 916:	8b 45 f0             	mov    -0x10(%ebp),%eax
 919:	89 10                	mov    %edx,(%eax)
 91b:	eb 26                	jmp    943 <malloc+0x96>
      else {
        p->s.size -= nunits;
 91d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 920:	8b 40 04             	mov    0x4(%eax),%eax
 923:	2b 45 ec             	sub    -0x14(%ebp),%eax
 926:	89 c2                	mov    %eax,%edx
 928:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 92e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 931:	8b 40 04             	mov    0x4(%eax),%eax
 934:	c1 e0 03             	shl    $0x3,%eax
 937:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 93a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 940:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 943:	8b 45 f0             	mov    -0x10(%ebp),%eax
 946:	a3 78 0c 00 00       	mov    %eax,0xc78
      return (void*)(p + 1);
 94b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94e:	83 c0 08             	add    $0x8,%eax
 951:	eb 3b                	jmp    98e <malloc+0xe1>
    }
    if(p == freep)
 953:	a1 78 0c 00 00       	mov    0xc78,%eax
 958:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 95b:	75 1e                	jne    97b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 95d:	83 ec 0c             	sub    $0xc,%esp
 960:	ff 75 ec             	pushl  -0x14(%ebp)
 963:	e8 e5 fe ff ff       	call   84d <morecore>
 968:	83 c4 10             	add    $0x10,%esp
 96b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 96e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 972:	75 07                	jne    97b <malloc+0xce>
        return 0;
 974:	b8 00 00 00 00       	mov    $0x0,%eax
 979:	eb 13                	jmp    98e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 981:	8b 45 f4             	mov    -0xc(%ebp),%eax
 984:	8b 00                	mov    (%eax),%eax
 986:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 989:	e9 6d ff ff ff       	jmp    8fb <malloc+0x4e>
}
 98e:	c9                   	leave  
 98f:	c3                   	ret    
