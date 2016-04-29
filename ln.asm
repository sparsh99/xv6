
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 94 09 00 00       	push   $0x994
  1e:	6a 02                	push   $0x2
  20:	e8 b7 05 00 00       	call   5dc <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit();
  28:	e8 38 04 00 00       	call   465 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2d:	8b 43 04             	mov    0x4(%ebx),%eax
  30:	83 c0 08             	add    $0x8,%eax
  33:	8b 10                	mov    (%eax),%edx
  35:	8b 43 04             	mov    0x4(%ebx),%eax
  38:	83 c0 04             	add    $0x4,%eax
  3b:	8b 00                	mov    (%eax),%eax
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	52                   	push   %edx
  41:	50                   	push   %eax
  42:	e8 7e 04 00 00       	call   4c5 <link>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	83 c0 08             	add    $0x8,%eax
  54:	8b 10                	mov    (%eax),%edx
  56:	8b 43 04             	mov    0x4(%ebx),%eax
  59:	83 c0 04             	add    $0x4,%eax
  5c:	8b 00                	mov    (%eax),%eax
  5e:	52                   	push   %edx
  5f:	50                   	push   %eax
  60:	68 a7 09 00 00       	push   $0x9a7
  65:	6a 02                	push   $0x2
  67:	e8 70 05 00 00       	call   5dc <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  exit();
  6f:	e8 f1 03 00 00       	call   465 <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7c:	8b 55 10             	mov    0x10(%ebp),%edx
  7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  82:	89 cb                	mov    %ecx,%ebx
  84:	89 df                	mov    %ebx,%edi
  86:	89 d1                	mov    %edx,%ecx
  88:	fc                   	cld    
  89:	f3 aa                	rep stos %al,%es:(%edi)
  8b:	89 ca                	mov    %ecx,%edx
  8d:	89 fb                	mov    %edi,%ebx
  8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  95:	90                   	nop
  96:	5b                   	pop    %ebx
  97:	5f                   	pop    %edi
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9a:	55                   	push   %ebp
  9b:	89 e5                	mov    %esp,%ebp
  9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a6:	90                   	nop
  a7:	8b 45 08             	mov    0x8(%ebp),%eax
  aa:	8d 50 01             	lea    0x1(%eax),%edx
  ad:	89 55 08             	mov    %edx,0x8(%ebp)
  b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  b3:	8d 4a 01             	lea    0x1(%edx),%ecx
  b6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b9:	0f b6 12             	movzbl (%edx),%edx
  bc:	88 10                	mov    %dl,(%eax)
  be:	0f b6 00             	movzbl (%eax),%eax
  c1:	84 c0                	test   %al,%al
  c3:	75 e2                	jne    a7 <strcpy+0xd>
    ;
  return os;
  c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c8:	c9                   	leave  
  c9:	c3                   	ret    

000000ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cd:	eb 08                	jmp    d7 <strcmp+0xd>
    p++, q++;
  cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	84 c0                	test   %al,%al
  df:	74 10                	je     f1 <strcmp+0x27>
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	0f b6 10             	movzbl (%eax),%edx
  e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  ea:	0f b6 00             	movzbl (%eax),%eax
  ed:	38 c2                	cmp    %al,%dl
  ef:	74 de                	je     cf <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	0f b6 d0             	movzbl %al,%edx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	0f b6 c0             	movzbl %al,%eax
 103:	29 c2                	sub    %eax,%edx
 105:	89 d0                	mov    %edx,%eax
}
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    

00000109 <strlen>:

uint
strlen(char *s)
{
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 116:	eb 04                	jmp    11c <strlen+0x13>
 118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11f:	8b 45 08             	mov    0x8(%ebp),%eax
 122:	01 d0                	add    %edx,%eax
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	84 c0                	test   %al,%al
 129:	75 ed                	jne    118 <strlen+0xf>
    ;
  return n;
 12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12e:	c9                   	leave  
 12f:	c3                   	ret    

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 133:	8b 45 10             	mov    0x10(%ebp),%eax
 136:	50                   	push   %eax
 137:	ff 75 0c             	pushl  0xc(%ebp)
 13a:	ff 75 08             	pushl  0x8(%ebp)
 13d:	e8 32 ff ff ff       	call   74 <stosb>
 142:	83 c4 0c             	add    $0xc,%esp
  return dst;
 145:	8b 45 08             	mov    0x8(%ebp),%eax
}
 148:	c9                   	leave  
 149:	c3                   	ret    

0000014a <strchr>:

char*
strchr(const char *s, char c)
{
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 04             	sub    $0x4,%esp
 150:	8b 45 0c             	mov    0xc(%ebp),%eax
 153:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 156:	eb 14                	jmp    16c <strchr+0x22>
    if(*s == c)
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 161:	75 05                	jne    168 <strchr+0x1e>
      return (char*)s;
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	eb 13                	jmp    17b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	84 c0                	test   %al,%al
 174:	75 e2                	jne    158 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 176:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17b:	c9                   	leave  
 17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
 17d:	55                   	push   %ebp
 17e:	89 e5                	mov    %esp,%ebp
 180:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18a:	eb 42                	jmp    1ce <gets+0x51>
    cc = read(0, &c, 1);
 18c:	83 ec 04             	sub    $0x4,%esp
 18f:	6a 01                	push   $0x1
 191:	8d 45 ef             	lea    -0x11(%ebp),%eax
 194:	50                   	push   %eax
 195:	6a 00                	push   $0x0
 197:	e8 e1 02 00 00       	call   47d <read>
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a6:	7e 33                	jle    1db <gets+0x5e>
      break;
    buf[i++] = c;
 1a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ab:	8d 50 01             	lea    0x1(%eax),%edx
 1ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b1:	89 c2                	mov    %eax,%edx
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	01 c2                	add    %eax,%edx
 1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bc:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c2:	3c 0a                	cmp    $0xa,%al
 1c4:	74 16                	je     1dc <gets+0x5f>
 1c6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ca:	3c 0d                	cmp    $0xd,%al
 1cc:	74 0e                	je     1dc <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d1:	83 c0 01             	add    $0x1,%eax
 1d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d7:	7c b3                	jl     18c <gets+0xf>
 1d9:	eb 01                	jmp    1dc <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1db:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	01 d0                	add    %edx,%eax
 1e4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ea:	c9                   	leave  
 1eb:	c3                   	ret    

000001ec <stat>:

int
stat(char *n, struct stat *st)
{
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f2:	83 ec 08             	sub    $0x8,%esp
 1f5:	6a 00                	push   $0x0
 1f7:	ff 75 08             	pushl  0x8(%ebp)
 1fa:	e8 a6 02 00 00       	call   4a5 <open>
 1ff:	83 c4 10             	add    $0x10,%esp
 202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 209:	79 07                	jns    212 <stat+0x26>
    return -1;
 20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 210:	eb 25                	jmp    237 <stat+0x4b>
  r = fstat(fd, st);
 212:	83 ec 08             	sub    $0x8,%esp
 215:	ff 75 0c             	pushl  0xc(%ebp)
 218:	ff 75 f4             	pushl  -0xc(%ebp)
 21b:	e8 9d 02 00 00       	call   4bd <fstat>
 220:	83 c4 10             	add    $0x10,%esp
 223:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 226:	83 ec 0c             	sub    $0xc,%esp
 229:	ff 75 f4             	pushl  -0xc(%ebp)
 22c:	e8 5c 02 00 00       	call   48d <close>
 231:	83 c4 10             	add    $0x10,%esp
  return r;
 234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 237:	c9                   	leave  
 238:	c3                   	ret    

00000239 <atoi>:

int
atoi(const char *s)
{
 239:	55                   	push   %ebp
 23a:	89 e5                	mov    %esp,%ebp
 23c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 246:	eb 25                	jmp    26d <atoi+0x34>
    n = n*10 + *s++ - '0';
 248:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24b:	89 d0                	mov    %edx,%eax
 24d:	c1 e0 02             	shl    $0x2,%eax
 250:	01 d0                	add    %edx,%eax
 252:	01 c0                	add    %eax,%eax
 254:	89 c1                	mov    %eax,%ecx
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 08             	mov    %edx,0x8(%ebp)
 25f:	0f b6 00             	movzbl (%eax),%eax
 262:	0f be c0             	movsbl %al,%eax
 265:	01 c8                	add    %ecx,%eax
 267:	83 e8 30             	sub    $0x30,%eax
 26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2f                	cmp    $0x2f,%al
 275:	7e 0a                	jle    281 <atoi+0x48>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 39                	cmp    $0x39,%al
 27f:	7e c7                	jle    248 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 292:	8b 45 0c             	mov    0xc(%ebp),%eax
 295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 298:	eb 17                	jmp    2b1 <memmove+0x2b>
    *dst++ = *src++;
 29a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 29d:	8d 50 01             	lea    0x1(%eax),%edx
 2a0:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a6:	8d 4a 01             	lea    0x1(%edx),%ecx
 2a9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2ac:	0f b6 12             	movzbl (%edx),%edx
 2af:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b1:	8b 45 10             	mov    0x10(%ebp),%eax
 2b4:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b7:	89 55 10             	mov    %edx,0x10(%ebp)
 2ba:	85 c0                	test   %eax,%eax
 2bc:	7f dc                	jg     29a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c1:	c9                   	leave  
 2c2:	c3                   	ret    

000002c3 <historyAdd>:

void
historyAdd(char *buf1){
 2c3:	55                   	push   %ebp
 2c4:	89 e5                	mov    %esp,%ebp
 2c6:	53                   	push   %ebx
 2c7:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 2cd:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 2d4:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 2db:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 2e1:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 2e5:	83 ec 08             	sub    $0x8,%esp
 2e8:	6a 00                	push   $0x0
 2ea:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 2ed:	50                   	push   %eax
 2ee:	e8 b2 01 00 00       	call   4a5 <open>
 2f3:	83 c4 10             	add    $0x10,%esp
 2f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2fd:	79 1b                	jns    31a <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 2ff:	83 ec 04             	sub    $0x4,%esp
 302:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 305:	50                   	push   %eax
 306:	68 bc 09 00 00       	push   $0x9bc
 30b:	6a 01                	push   $0x1
 30d:	e8 ca 02 00 00       	call   5dc <printf>
 312:	83 c4 10             	add    $0x10,%esp
       exit();
 315:	e8 4b 01 00 00       	call   465 <exit>
     }

     int i=0;
 31a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 321:	eb 1c                	jmp    33f <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 323:	8b 55 f4             	mov    -0xc(%ebp),%edx
 326:	8b 45 08             	mov    0x8(%ebp),%eax
 329:	01 d0                	add    %edx,%eax
 32b:	0f b6 00             	movzbl (%eax),%eax
 32e:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 334:	8b 55 f4             	mov    -0xc(%ebp),%edx
 337:	01 ca                	add    %ecx,%edx
 339:	88 02                	mov    %al,(%edx)
	i++;
 33b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 33f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 342:	8b 45 08             	mov    0x8(%ebp),%eax
 345:	01 d0                	add    %edx,%eax
 347:	0f b6 00             	movzbl (%eax),%eax
 34a:	84 c0                	test   %al,%al
 34c:	75 d5                	jne    323 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 34e:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 354:	8b 45 f4             	mov    -0xc(%ebp),%eax
 357:	01 d0                	add    %edx,%eax
 359:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 35c:	eb 5a                	jmp    3b8 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 35e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 361:	83 ec 0c             	sub    $0xc,%esp
 364:	ff 75 08             	pushl  0x8(%ebp)
 367:	e8 9d fd ff ff       	call   109 <strlen>
 36c:	83 c4 10             	add    $0x10,%esp
 36f:	29 c3                	sub    %eax,%ebx
 371:	89 d8                	mov    %ebx,%eax
 373:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 37a:	ff 
 37b:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 381:	8b 55 f4             	mov    -0xc(%ebp),%edx
 384:	01 ca                	add    %ecx,%edx
 386:	88 02                	mov    %al,(%edx)
		i++;
 388:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 38c:	83 ec 0c             	sub    $0xc,%esp
 38f:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 395:	50                   	push   %eax
 396:	e8 6e fd ff ff       	call   109 <strlen>
 39b:	83 c4 10             	add    $0x10,%esp
 39e:	89 c3                	mov    %eax,%ebx
 3a0:	83 ec 0c             	sub    $0xc,%esp
 3a3:	ff 75 08             	pushl  0x8(%ebp)
 3a6:	e8 5e fd ff ff       	call   109 <strlen>
 3ab:	83 c4 10             	add    $0x10,%esp
 3ae:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 3b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3b4:	39 c2                	cmp    %eax,%edx
 3b6:	77 a6                	ja     35e <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3b8:	83 ec 04             	sub    $0x4,%esp
 3bb:	68 e8 03 00 00       	push   $0x3e8
 3c0:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 3c6:	50                   	push   %eax
 3c7:	ff 75 f0             	pushl  -0x10(%ebp)
 3ca:	e8 ae 00 00 00       	call   47d <read>
 3cf:	83 c4 10             	add    $0x10,%esp
 3d2:	85 c0                	test   %eax,%eax
 3d4:	7f b6                	jg     38c <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 3d6:	83 ec 0c             	sub    $0xc,%esp
 3d9:	ff 75 f0             	pushl  -0x10(%ebp)
 3dc:	e8 ac 00 00 00       	call   48d <close>
 3e1:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 3e4:	83 ec 08             	sub    $0x8,%esp
 3e7:	68 02 02 00 00       	push   $0x202
 3ec:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3ef:	50                   	push   %eax
 3f0:	e8 b0 00 00 00       	call   4a5 <open>
 3f5:	83 c4 10             	add    $0x10,%esp
 3f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 3fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3ff:	79 1b                	jns    41c <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 401:	83 ec 04             	sub    $0x4,%esp
 404:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 407:	50                   	push   %eax
 408:	68 bc 09 00 00       	push   $0x9bc
 40d:	6a 01                	push   $0x1
 40f:	e8 c8 01 00 00       	call   5dc <printf>
 414:	83 c4 10             	add    $0x10,%esp
       exit();
 417:	e8 49 00 00 00       	call   465 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 41c:	83 ec 04             	sub    $0x4,%esp
 41f:	68 e8 03 00 00       	push   $0x3e8
 424:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 42a:	50                   	push   %eax
 42b:	ff 75 f0             	pushl  -0x10(%ebp)
 42e:	e8 52 00 00 00       	call   485 <write>
 433:	83 c4 10             	add    $0x10,%esp
 436:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 43b:	74 1a                	je     457 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 43d:	83 ec 04             	sub    $0x4,%esp
 440:	ff 75 f4             	pushl  -0xc(%ebp)
 443:	68 d8 09 00 00       	push   $0x9d8
 448:	6a 01                	push   $0x1
 44a:	e8 8d 01 00 00       	call   5dc <printf>
 44f:	83 c4 10             	add    $0x10,%esp
       exit();
 452:	e8 0e 00 00 00       	call   465 <exit>
     }
    
}
 457:	90                   	nop
 458:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 45b:	c9                   	leave  
 45c:	c3                   	ret    

0000045d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 45d:	b8 01 00 00 00       	mov    $0x1,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <exit>:
SYSCALL(exit)
 465:	b8 02 00 00 00       	mov    $0x2,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <wait>:
SYSCALL(wait)
 46d:	b8 03 00 00 00       	mov    $0x3,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <pipe>:
SYSCALL(pipe)
 475:	b8 04 00 00 00       	mov    $0x4,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <read>:
SYSCALL(read)
 47d:	b8 05 00 00 00       	mov    $0x5,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <write>:
SYSCALL(write)
 485:	b8 10 00 00 00       	mov    $0x10,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <close>:
SYSCALL(close)
 48d:	b8 15 00 00 00       	mov    $0x15,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <kill>:
SYSCALL(kill)
 495:	b8 06 00 00 00       	mov    $0x6,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret    

0000049d <exec>:
SYSCALL(exec)
 49d:	b8 07 00 00 00       	mov    $0x7,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret    

000004a5 <open>:
SYSCALL(open)
 4a5:	b8 0f 00 00 00       	mov    $0xf,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret    

000004ad <mknod>:
SYSCALL(mknod)
 4ad:	b8 11 00 00 00       	mov    $0x11,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret    

000004b5 <unlink>:
SYSCALL(unlink)
 4b5:	b8 12 00 00 00       	mov    $0x12,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret    

000004bd <fstat>:
SYSCALL(fstat)
 4bd:	b8 08 00 00 00       	mov    $0x8,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret    

000004c5 <link>:
SYSCALL(link)
 4c5:	b8 13 00 00 00       	mov    $0x13,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret    

000004cd <mkdir>:
SYSCALL(mkdir)
 4cd:	b8 14 00 00 00       	mov    $0x14,%eax
 4d2:	cd 40                	int    $0x40
 4d4:	c3                   	ret    

000004d5 <chdir>:
SYSCALL(chdir)
 4d5:	b8 09 00 00 00       	mov    $0x9,%eax
 4da:	cd 40                	int    $0x40
 4dc:	c3                   	ret    

000004dd <dup>:
SYSCALL(dup)
 4dd:	b8 0a 00 00 00       	mov    $0xa,%eax
 4e2:	cd 40                	int    $0x40
 4e4:	c3                   	ret    

000004e5 <getpid>:
SYSCALL(getpid)
 4e5:	b8 0b 00 00 00       	mov    $0xb,%eax
 4ea:	cd 40                	int    $0x40
 4ec:	c3                   	ret    

000004ed <sbrk>:
SYSCALL(sbrk)
 4ed:	b8 0c 00 00 00       	mov    $0xc,%eax
 4f2:	cd 40                	int    $0x40
 4f4:	c3                   	ret    

000004f5 <sleep>:
SYSCALL(sleep)
 4f5:	b8 0d 00 00 00       	mov    $0xd,%eax
 4fa:	cd 40                	int    $0x40
 4fc:	c3                   	ret    

000004fd <uptime>:
SYSCALL(uptime)
 4fd:	b8 0e 00 00 00       	mov    $0xe,%eax
 502:	cd 40                	int    $0x40
 504:	c3                   	ret    

00000505 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 505:	55                   	push   %ebp
 506:	89 e5                	mov    %esp,%ebp
 508:	83 ec 18             	sub    $0x18,%esp
 50b:	8b 45 0c             	mov    0xc(%ebp),%eax
 50e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 511:	83 ec 04             	sub    $0x4,%esp
 514:	6a 01                	push   $0x1
 516:	8d 45 f4             	lea    -0xc(%ebp),%eax
 519:	50                   	push   %eax
 51a:	ff 75 08             	pushl  0x8(%ebp)
 51d:	e8 63 ff ff ff       	call   485 <write>
 522:	83 c4 10             	add    $0x10,%esp
}
 525:	90                   	nop
 526:	c9                   	leave  
 527:	c3                   	ret    

00000528 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 528:	55                   	push   %ebp
 529:	89 e5                	mov    %esp,%ebp
 52b:	53                   	push   %ebx
 52c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 52f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 536:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 53a:	74 17                	je     553 <printint+0x2b>
 53c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 540:	79 11                	jns    553 <printint+0x2b>
    neg = 1;
 542:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 549:	8b 45 0c             	mov    0xc(%ebp),%eax
 54c:	f7 d8                	neg    %eax
 54e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 551:	eb 06                	jmp    559 <printint+0x31>
  } else {
    x = xx;
 553:	8b 45 0c             	mov    0xc(%ebp),%eax
 556:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 559:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 560:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 563:	8d 41 01             	lea    0x1(%ecx),%eax
 566:	89 45 f4             	mov    %eax,-0xc(%ebp)
 569:	8b 5d 10             	mov    0x10(%ebp),%ebx
 56c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 56f:	ba 00 00 00 00       	mov    $0x0,%edx
 574:	f7 f3                	div    %ebx
 576:	89 d0                	mov    %edx,%eax
 578:	0f b6 80 74 0c 00 00 	movzbl 0xc74(%eax),%eax
 57f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 583:	8b 5d 10             	mov    0x10(%ebp),%ebx
 586:	8b 45 ec             	mov    -0x14(%ebp),%eax
 589:	ba 00 00 00 00       	mov    $0x0,%edx
 58e:	f7 f3                	div    %ebx
 590:	89 45 ec             	mov    %eax,-0x14(%ebp)
 593:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 597:	75 c7                	jne    560 <printint+0x38>
  if(neg)
 599:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 59d:	74 2d                	je     5cc <printint+0xa4>
    buf[i++] = '-';
 59f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a2:	8d 50 01             	lea    0x1(%eax),%edx
 5a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5a8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5ad:	eb 1d                	jmp    5cc <printint+0xa4>
    putc(fd, buf[i]);
 5af:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b5:	01 d0                	add    %edx,%eax
 5b7:	0f b6 00             	movzbl (%eax),%eax
 5ba:	0f be c0             	movsbl %al,%eax
 5bd:	83 ec 08             	sub    $0x8,%esp
 5c0:	50                   	push   %eax
 5c1:	ff 75 08             	pushl  0x8(%ebp)
 5c4:	e8 3c ff ff ff       	call   505 <putc>
 5c9:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5cc:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d4:	79 d9                	jns    5af <printint+0x87>
    putc(fd, buf[i]);
}
 5d6:	90                   	nop
 5d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5da:	c9                   	leave  
 5db:	c3                   	ret    

000005dc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5dc:	55                   	push   %ebp
 5dd:	89 e5                	mov    %esp,%ebp
 5df:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5e9:	8d 45 0c             	lea    0xc(%ebp),%eax
 5ec:	83 c0 04             	add    $0x4,%eax
 5ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5f9:	e9 59 01 00 00       	jmp    757 <printf+0x17b>
    c = fmt[i] & 0xff;
 5fe:	8b 55 0c             	mov    0xc(%ebp),%edx
 601:	8b 45 f0             	mov    -0x10(%ebp),%eax
 604:	01 d0                	add    %edx,%eax
 606:	0f b6 00             	movzbl (%eax),%eax
 609:	0f be c0             	movsbl %al,%eax
 60c:	25 ff 00 00 00       	and    $0xff,%eax
 611:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 614:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 618:	75 2c                	jne    646 <printf+0x6a>
      if(c == '%'){
 61a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 61e:	75 0c                	jne    62c <printf+0x50>
        state = '%';
 620:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 627:	e9 27 01 00 00       	jmp    753 <printf+0x177>
      } else {
        putc(fd, c);
 62c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62f:	0f be c0             	movsbl %al,%eax
 632:	83 ec 08             	sub    $0x8,%esp
 635:	50                   	push   %eax
 636:	ff 75 08             	pushl  0x8(%ebp)
 639:	e8 c7 fe ff ff       	call   505 <putc>
 63e:	83 c4 10             	add    $0x10,%esp
 641:	e9 0d 01 00 00       	jmp    753 <printf+0x177>
      }
    } else if(state == '%'){
 646:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 64a:	0f 85 03 01 00 00    	jne    753 <printf+0x177>
      if(c == 'd'){
 650:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 654:	75 1e                	jne    674 <printf+0x98>
        printint(fd, *ap, 10, 1);
 656:	8b 45 e8             	mov    -0x18(%ebp),%eax
 659:	8b 00                	mov    (%eax),%eax
 65b:	6a 01                	push   $0x1
 65d:	6a 0a                	push   $0xa
 65f:	50                   	push   %eax
 660:	ff 75 08             	pushl  0x8(%ebp)
 663:	e8 c0 fe ff ff       	call   528 <printint>
 668:	83 c4 10             	add    $0x10,%esp
        ap++;
 66b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 66f:	e9 d8 00 00 00       	jmp    74c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 674:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 678:	74 06                	je     680 <printf+0xa4>
 67a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 67e:	75 1e                	jne    69e <printf+0xc2>
        printint(fd, *ap, 16, 0);
 680:	8b 45 e8             	mov    -0x18(%ebp),%eax
 683:	8b 00                	mov    (%eax),%eax
 685:	6a 00                	push   $0x0
 687:	6a 10                	push   $0x10
 689:	50                   	push   %eax
 68a:	ff 75 08             	pushl  0x8(%ebp)
 68d:	e8 96 fe ff ff       	call   528 <printint>
 692:	83 c4 10             	add    $0x10,%esp
        ap++;
 695:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 699:	e9 ae 00 00 00       	jmp    74c <printf+0x170>
      } else if(c == 's'){
 69e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6a2:	75 43                	jne    6e7 <printf+0x10b>
        s = (char*)*ap;
 6a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a7:	8b 00                	mov    (%eax),%eax
 6a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6b4:	75 25                	jne    6db <printf+0xff>
          s = "(null)";
 6b6:	c7 45 f4 fc 09 00 00 	movl   $0x9fc,-0xc(%ebp)
        while(*s != 0){
 6bd:	eb 1c                	jmp    6db <printf+0xff>
          putc(fd, *s);
 6bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c2:	0f b6 00             	movzbl (%eax),%eax
 6c5:	0f be c0             	movsbl %al,%eax
 6c8:	83 ec 08             	sub    $0x8,%esp
 6cb:	50                   	push   %eax
 6cc:	ff 75 08             	pushl  0x8(%ebp)
 6cf:	e8 31 fe ff ff       	call   505 <putc>
 6d4:	83 c4 10             	add    $0x10,%esp
          s++;
 6d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6de:	0f b6 00             	movzbl (%eax),%eax
 6e1:	84 c0                	test   %al,%al
 6e3:	75 da                	jne    6bf <printf+0xe3>
 6e5:	eb 65                	jmp    74c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6eb:	75 1d                	jne    70a <printf+0x12e>
        putc(fd, *ap);
 6ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6f0:	8b 00                	mov    (%eax),%eax
 6f2:	0f be c0             	movsbl %al,%eax
 6f5:	83 ec 08             	sub    $0x8,%esp
 6f8:	50                   	push   %eax
 6f9:	ff 75 08             	pushl  0x8(%ebp)
 6fc:	e8 04 fe ff ff       	call   505 <putc>
 701:	83 c4 10             	add    $0x10,%esp
        ap++;
 704:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 708:	eb 42                	jmp    74c <printf+0x170>
      } else if(c == '%'){
 70a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 70e:	75 17                	jne    727 <printf+0x14b>
        putc(fd, c);
 710:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 713:	0f be c0             	movsbl %al,%eax
 716:	83 ec 08             	sub    $0x8,%esp
 719:	50                   	push   %eax
 71a:	ff 75 08             	pushl  0x8(%ebp)
 71d:	e8 e3 fd ff ff       	call   505 <putc>
 722:	83 c4 10             	add    $0x10,%esp
 725:	eb 25                	jmp    74c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 727:	83 ec 08             	sub    $0x8,%esp
 72a:	6a 25                	push   $0x25
 72c:	ff 75 08             	pushl  0x8(%ebp)
 72f:	e8 d1 fd ff ff       	call   505 <putc>
 734:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 737:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 73a:	0f be c0             	movsbl %al,%eax
 73d:	83 ec 08             	sub    $0x8,%esp
 740:	50                   	push   %eax
 741:	ff 75 08             	pushl  0x8(%ebp)
 744:	e8 bc fd ff ff       	call   505 <putc>
 749:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 74c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 753:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 757:	8b 55 0c             	mov    0xc(%ebp),%edx
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	01 d0                	add    %edx,%eax
 75f:	0f b6 00             	movzbl (%eax),%eax
 762:	84 c0                	test   %al,%al
 764:	0f 85 94 fe ff ff    	jne    5fe <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 76a:	90                   	nop
 76b:	c9                   	leave  
 76c:	c3                   	ret    

0000076d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 76d:	55                   	push   %ebp
 76e:	89 e5                	mov    %esp,%ebp
 770:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 773:	8b 45 08             	mov    0x8(%ebp),%eax
 776:	83 e8 08             	sub    $0x8,%eax
 779:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77c:	a1 90 0c 00 00       	mov    0xc90,%eax
 781:	89 45 fc             	mov    %eax,-0x4(%ebp)
 784:	eb 24                	jmp    7aa <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 786:	8b 45 fc             	mov    -0x4(%ebp),%eax
 789:	8b 00                	mov    (%eax),%eax
 78b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 78e:	77 12                	ja     7a2 <free+0x35>
 790:	8b 45 f8             	mov    -0x8(%ebp),%eax
 793:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 796:	77 24                	ja     7bc <free+0x4f>
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 00                	mov    (%eax),%eax
 79d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a0:	77 1a                	ja     7bc <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 00                	mov    (%eax),%eax
 7a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ad:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b0:	76 d4                	jbe    786 <free+0x19>
 7b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b5:	8b 00                	mov    (%eax),%eax
 7b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7ba:	76 ca                	jbe    786 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bf:	8b 40 04             	mov    0x4(%eax),%eax
 7c2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cc:	01 c2                	add    %eax,%edx
 7ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	39 c2                	cmp    %eax,%edx
 7d5:	75 24                	jne    7fb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7da:	8b 50 04             	mov    0x4(%eax),%edx
 7dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e0:	8b 00                	mov    (%eax),%eax
 7e2:	8b 40 04             	mov    0x4(%eax),%eax
 7e5:	01 c2                	add    %eax,%edx
 7e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ea:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f0:	8b 00                	mov    (%eax),%eax
 7f2:	8b 10                	mov    (%eax),%edx
 7f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f7:	89 10                	mov    %edx,(%eax)
 7f9:	eb 0a                	jmp    805 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fe:	8b 10                	mov    (%eax),%edx
 800:	8b 45 f8             	mov    -0x8(%ebp),%eax
 803:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 805:	8b 45 fc             	mov    -0x4(%ebp),%eax
 808:	8b 40 04             	mov    0x4(%eax),%eax
 80b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 812:	8b 45 fc             	mov    -0x4(%ebp),%eax
 815:	01 d0                	add    %edx,%eax
 817:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 81a:	75 20                	jne    83c <free+0xcf>
    p->s.size += bp->s.size;
 81c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81f:	8b 50 04             	mov    0x4(%eax),%edx
 822:	8b 45 f8             	mov    -0x8(%ebp),%eax
 825:	8b 40 04             	mov    0x4(%eax),%eax
 828:	01 c2                	add    %eax,%edx
 82a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 830:	8b 45 f8             	mov    -0x8(%ebp),%eax
 833:	8b 10                	mov    (%eax),%edx
 835:	8b 45 fc             	mov    -0x4(%ebp),%eax
 838:	89 10                	mov    %edx,(%eax)
 83a:	eb 08                	jmp    844 <free+0xd7>
  } else
    p->s.ptr = bp;
 83c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 842:	89 10                	mov    %edx,(%eax)
  freep = p;
 844:	8b 45 fc             	mov    -0x4(%ebp),%eax
 847:	a3 90 0c 00 00       	mov    %eax,0xc90
}
 84c:	90                   	nop
 84d:	c9                   	leave  
 84e:	c3                   	ret    

0000084f <morecore>:

static Header*
morecore(uint nu)
{
 84f:	55                   	push   %ebp
 850:	89 e5                	mov    %esp,%ebp
 852:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 855:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 85c:	77 07                	ja     865 <morecore+0x16>
    nu = 4096;
 85e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 865:	8b 45 08             	mov    0x8(%ebp),%eax
 868:	c1 e0 03             	shl    $0x3,%eax
 86b:	83 ec 0c             	sub    $0xc,%esp
 86e:	50                   	push   %eax
 86f:	e8 79 fc ff ff       	call   4ed <sbrk>
 874:	83 c4 10             	add    $0x10,%esp
 877:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 87a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 87e:	75 07                	jne    887 <morecore+0x38>
    return 0;
 880:	b8 00 00 00 00       	mov    $0x0,%eax
 885:	eb 26                	jmp    8ad <morecore+0x5e>
  hp = (Header*)p;
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 88d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 890:	8b 55 08             	mov    0x8(%ebp),%edx
 893:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 896:	8b 45 f0             	mov    -0x10(%ebp),%eax
 899:	83 c0 08             	add    $0x8,%eax
 89c:	83 ec 0c             	sub    $0xc,%esp
 89f:	50                   	push   %eax
 8a0:	e8 c8 fe ff ff       	call   76d <free>
 8a5:	83 c4 10             	add    $0x10,%esp
  return freep;
 8a8:	a1 90 0c 00 00       	mov    0xc90,%eax
}
 8ad:	c9                   	leave  
 8ae:	c3                   	ret    

000008af <malloc>:

void*
malloc(uint nbytes)
{
 8af:	55                   	push   %ebp
 8b0:	89 e5                	mov    %esp,%ebp
 8b2:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b5:	8b 45 08             	mov    0x8(%ebp),%eax
 8b8:	83 c0 07             	add    $0x7,%eax
 8bb:	c1 e8 03             	shr    $0x3,%eax
 8be:	83 c0 01             	add    $0x1,%eax
 8c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8c4:	a1 90 0c 00 00       	mov    0xc90,%eax
 8c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8d0:	75 23                	jne    8f5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8d2:	c7 45 f0 88 0c 00 00 	movl   $0xc88,-0x10(%ebp)
 8d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8dc:	a3 90 0c 00 00       	mov    %eax,0xc90
 8e1:	a1 90 0c 00 00       	mov    0xc90,%eax
 8e6:	a3 88 0c 00 00       	mov    %eax,0xc88
    base.s.size = 0;
 8eb:	c7 05 8c 0c 00 00 00 	movl   $0x0,0xc8c
 8f2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f8:	8b 00                	mov    (%eax),%eax
 8fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 900:	8b 40 04             	mov    0x4(%eax),%eax
 903:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 906:	72 4d                	jb     955 <malloc+0xa6>
      if(p->s.size == nunits)
 908:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90b:	8b 40 04             	mov    0x4(%eax),%eax
 90e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 911:	75 0c                	jne    91f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 913:	8b 45 f4             	mov    -0xc(%ebp),%eax
 916:	8b 10                	mov    (%eax),%edx
 918:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91b:	89 10                	mov    %edx,(%eax)
 91d:	eb 26                	jmp    945 <malloc+0x96>
      else {
        p->s.size -= nunits;
 91f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 922:	8b 40 04             	mov    0x4(%eax),%eax
 925:	2b 45 ec             	sub    -0x14(%ebp),%eax
 928:	89 c2                	mov    %eax,%edx
 92a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 930:	8b 45 f4             	mov    -0xc(%ebp),%eax
 933:	8b 40 04             	mov    0x4(%eax),%eax
 936:	c1 e0 03             	shl    $0x3,%eax
 939:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 93c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 942:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 945:	8b 45 f0             	mov    -0x10(%ebp),%eax
 948:	a3 90 0c 00 00       	mov    %eax,0xc90
      return (void*)(p + 1);
 94d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 950:	83 c0 08             	add    $0x8,%eax
 953:	eb 3b                	jmp    990 <malloc+0xe1>
    }
    if(p == freep)
 955:	a1 90 0c 00 00       	mov    0xc90,%eax
 95a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 95d:	75 1e                	jne    97d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 95f:	83 ec 0c             	sub    $0xc,%esp
 962:	ff 75 ec             	pushl  -0x14(%ebp)
 965:	e8 e5 fe ff ff       	call   84f <morecore>
 96a:	83 c4 10             	add    $0x10,%esp
 96d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 970:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 974:	75 07                	jne    97d <malloc+0xce>
        return 0;
 976:	b8 00 00 00 00       	mov    $0x0,%eax
 97b:	eb 13                	jmp    990 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 980:	89 45 f0             	mov    %eax,-0x10(%ebp)
 983:	8b 45 f4             	mov    -0xc(%ebp),%eax
 986:	8b 00                	mov    (%eax),%eax
 988:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 98b:	e9 6d ff ff ff       	jmp    8fd <malloc+0x4e>
}
 990:	c9                   	leave  
 991:	c3                   	ret    
