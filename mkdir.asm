
_mkdir:     file format elf32-i386


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
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: mkdir files...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 b0 09 00 00       	push   $0x9b0
  21:	6a 02                	push   $0x2
  23:	e8 d0 05 00 00       	call   5f8 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 51 04 00 00       	call   481 <exit>
  }

  for(i = 1; i < argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 4b                	jmp    84 <main+0x84>
    if(mkdir(argv[i]) < 0){
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 96 04 00 00       	call   4e9 <mkdir>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	79 26                	jns    80 <main+0x80>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  64:	8b 43 04             	mov    0x4(%ebx),%eax
  67:	01 d0                	add    %edx,%eax
  69:	8b 00                	mov    (%eax),%eax
  6b:	83 ec 04             	sub    $0x4,%esp
  6e:	50                   	push   %eax
  6f:	68 c7 09 00 00       	push   $0x9c7
  74:	6a 02                	push   $0x2
  76:	e8 7d 05 00 00       	call   5f8 <printf>
  7b:	83 c4 10             	add    $0x10,%esp
      break;
  7e:	eb 0b                	jmp    8b <main+0x8b>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  87:	3b 03                	cmp    (%ebx),%eax
  89:	7c ae                	jl     39 <main+0x39>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  8b:	e8 f1 03 00 00       	call   481 <exit>

00000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  95:	8b 4d 08             	mov    0x8(%ebp),%ecx
  98:	8b 55 10             	mov    0x10(%ebp),%edx
  9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  9e:	89 cb                	mov    %ecx,%ebx
  a0:	89 df                	mov    %ebx,%edi
  a2:	89 d1                	mov    %edx,%ecx
  a4:	fc                   	cld    
  a5:	f3 aa                	rep stos %al,%es:(%edi)
  a7:	89 ca                	mov    %ecx,%edx
  a9:	89 fb                	mov    %edi,%ebx
  ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b1:	90                   	nop
  b2:	5b                   	pop    %ebx
  b3:	5f                   	pop    %edi
  b4:	5d                   	pop    %ebp
  b5:	c3                   	ret    

000000b6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b6:	55                   	push   %ebp
  b7:	89 e5                	mov    %esp,%ebp
  b9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  bc:	8b 45 08             	mov    0x8(%ebp),%eax
  bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c2:	90                   	nop
  c3:	8b 45 08             	mov    0x8(%ebp),%eax
  c6:	8d 50 01             	lea    0x1(%eax),%edx
  c9:	89 55 08             	mov    %edx,0x8(%ebp)
  cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  cf:	8d 4a 01             	lea    0x1(%edx),%ecx
  d2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d5:	0f b6 12             	movzbl (%edx),%edx
  d8:	88 10                	mov    %dl,(%eax)
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	84 c0                	test   %al,%al
  df:	75 e2                	jne    c3 <strcpy+0xd>
    ;
  return os;
  e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e4:	c9                   	leave  
  e5:	c3                   	ret    

000000e6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e6:	55                   	push   %ebp
  e7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e9:	eb 08                	jmp    f3 <strcmp+0xd>
    p++, q++;
  eb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ef:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 00             	movzbl (%eax),%eax
  f9:	84 c0                	test   %al,%al
  fb:	74 10                	je     10d <strcmp+0x27>
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
 100:	0f b6 10             	movzbl (%eax),%edx
 103:	8b 45 0c             	mov    0xc(%ebp),%eax
 106:	0f b6 00             	movzbl (%eax),%eax
 109:	38 c2                	cmp    %al,%dl
 10b:	74 de                	je     eb <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10d:	8b 45 08             	mov    0x8(%ebp),%eax
 110:	0f b6 00             	movzbl (%eax),%eax
 113:	0f b6 d0             	movzbl %al,%edx
 116:	8b 45 0c             	mov    0xc(%ebp),%eax
 119:	0f b6 00             	movzbl (%eax),%eax
 11c:	0f b6 c0             	movzbl %al,%eax
 11f:	29 c2                	sub    %eax,%edx
 121:	89 d0                	mov    %edx,%eax
}
 123:	5d                   	pop    %ebp
 124:	c3                   	ret    

00000125 <strlen>:

uint
strlen(char *s)
{
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
 128:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 12b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 132:	eb 04                	jmp    138 <strlen+0x13>
 134:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 138:	8b 55 fc             	mov    -0x4(%ebp),%edx
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	01 d0                	add    %edx,%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	84 c0                	test   %al,%al
 145:	75 ed                	jne    134 <strlen+0xf>
    ;
  return n;
 147:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 14a:	c9                   	leave  
 14b:	c3                   	ret    

0000014c <memset>:

void*
memset(void *dst, int c, uint n)
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 14f:	8b 45 10             	mov    0x10(%ebp),%eax
 152:	50                   	push   %eax
 153:	ff 75 0c             	pushl  0xc(%ebp)
 156:	ff 75 08             	pushl  0x8(%ebp)
 159:	e8 32 ff ff ff       	call   90 <stosb>
 15e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 161:	8b 45 08             	mov    0x8(%ebp),%eax
}
 164:	c9                   	leave  
 165:	c3                   	ret    

00000166 <strchr>:

char*
strchr(const char *s, char c)
{
 166:	55                   	push   %ebp
 167:	89 e5                	mov    %esp,%ebp
 169:	83 ec 04             	sub    $0x4,%esp
 16c:	8b 45 0c             	mov    0xc(%ebp),%eax
 16f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 172:	eb 14                	jmp    188 <strchr+0x22>
    if(*s == c)
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	0f b6 00             	movzbl (%eax),%eax
 17a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 17d:	75 05                	jne    184 <strchr+0x1e>
      return (char*)s;
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	eb 13                	jmp    197 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 184:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	0f b6 00             	movzbl (%eax),%eax
 18e:	84 c0                	test   %al,%al
 190:	75 e2                	jne    174 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 192:	b8 00 00 00 00       	mov    $0x0,%eax
}
 197:	c9                   	leave  
 198:	c3                   	ret    

00000199 <gets>:

char*
gets(char *buf, int max)
{
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a6:	eb 42                	jmp    1ea <gets+0x51>
    cc = read(0, &c, 1);
 1a8:	83 ec 04             	sub    $0x4,%esp
 1ab:	6a 01                	push   $0x1
 1ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 e1 02 00 00       	call   499 <read>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c2:	7e 33                	jle    1f7 <gets+0x5e>
      break;
    buf[i++] = c;
 1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c7:	8d 50 01             	lea    0x1(%eax),%edx
 1ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1cd:	89 c2                	mov    %eax,%edx
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	01 c2                	add    %eax,%edx
 1d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1de:	3c 0a                	cmp    $0xa,%al
 1e0:	74 16                	je     1f8 <gets+0x5f>
 1e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e6:	3c 0d                	cmp    $0xd,%al
 1e8:	74 0e                	je     1f8 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ed:	83 c0 01             	add    $0x1,%eax
 1f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f3:	7c b3                	jl     1a8 <gets+0xf>
 1f5:	eb 01                	jmp    1f8 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1f7:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	01 d0                	add    %edx,%eax
 200:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 203:	8b 45 08             	mov    0x8(%ebp),%eax
}
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <stat>:

int
stat(char *n, struct stat *st)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
 20b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20e:	83 ec 08             	sub    $0x8,%esp
 211:	6a 00                	push   $0x0
 213:	ff 75 08             	pushl  0x8(%ebp)
 216:	e8 a6 02 00 00       	call   4c1 <open>
 21b:	83 c4 10             	add    $0x10,%esp
 21e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 225:	79 07                	jns    22e <stat+0x26>
    return -1;
 227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22c:	eb 25                	jmp    253 <stat+0x4b>
  r = fstat(fd, st);
 22e:	83 ec 08             	sub    $0x8,%esp
 231:	ff 75 0c             	pushl  0xc(%ebp)
 234:	ff 75 f4             	pushl  -0xc(%ebp)
 237:	e8 9d 02 00 00       	call   4d9 <fstat>
 23c:	83 c4 10             	add    $0x10,%esp
 23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 242:	83 ec 0c             	sub    $0xc,%esp
 245:	ff 75 f4             	pushl  -0xc(%ebp)
 248:	e8 5c 02 00 00       	call   4a9 <close>
 24d:	83 c4 10             	add    $0x10,%esp
  return r;
 250:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 253:	c9                   	leave  
 254:	c3                   	ret    

00000255 <atoi>:

int
atoi(const char *s)
{
 255:	55                   	push   %ebp
 256:	89 e5                	mov    %esp,%ebp
 258:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 25b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 262:	eb 25                	jmp    289 <atoi+0x34>
    n = n*10 + *s++ - '0';
 264:	8b 55 fc             	mov    -0x4(%ebp),%edx
 267:	89 d0                	mov    %edx,%eax
 269:	c1 e0 02             	shl    $0x2,%eax
 26c:	01 d0                	add    %edx,%eax
 26e:	01 c0                	add    %eax,%eax
 270:	89 c1                	mov    %eax,%ecx
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	8d 50 01             	lea    0x1(%eax),%edx
 278:	89 55 08             	mov    %edx,0x8(%ebp)
 27b:	0f b6 00             	movzbl (%eax),%eax
 27e:	0f be c0             	movsbl %al,%eax
 281:	01 c8                	add    %ecx,%eax
 283:	83 e8 30             	sub    $0x30,%eax
 286:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	3c 2f                	cmp    $0x2f,%al
 291:	7e 0a                	jle    29d <atoi+0x48>
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	0f b6 00             	movzbl (%eax),%eax
 299:	3c 39                	cmp    $0x39,%al
 29b:	7e c7                	jle    264 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a0:	c9                   	leave  
 2a1:	c3                   	ret    

000002a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a2:	55                   	push   %ebp
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b4:	eb 17                	jmp    2cd <memmove+0x2b>
    *dst++ = *src++;
 2b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b9:	8d 50 01             	lea    0x1(%eax),%edx
 2bc:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2c2:	8d 4a 01             	lea    0x1(%edx),%ecx
 2c5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2c8:	0f b6 12             	movzbl (%edx),%edx
 2cb:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2cd:	8b 45 10             	mov    0x10(%ebp),%eax
 2d0:	8d 50 ff             	lea    -0x1(%eax),%edx
 2d3:	89 55 10             	mov    %edx,0x10(%ebp)
 2d6:	85 c0                	test   %eax,%eax
 2d8:	7f dc                	jg     2b6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2dd:	c9                   	leave  
 2de:	c3                   	ret    

000002df <historyAdd>:

void
historyAdd(char *buf1){
 2df:	55                   	push   %ebp
 2e0:	89 e5                	mov    %esp,%ebp
 2e2:	53                   	push   %ebx
 2e3:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 2e9:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 2f0:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 2f7:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 2fd:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 301:	83 ec 08             	sub    $0x8,%esp
 304:	6a 00                	push   $0x0
 306:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 309:	50                   	push   %eax
 30a:	e8 b2 01 00 00       	call   4c1 <open>
 30f:	83 c4 10             	add    $0x10,%esp
 312:	89 45 f0             	mov    %eax,-0x10(%ebp)
 315:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 319:	79 1b                	jns    336 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 31b:	83 ec 04             	sub    $0x4,%esp
 31e:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 321:	50                   	push   %eax
 322:	68 e4 09 00 00       	push   $0x9e4
 327:	6a 01                	push   $0x1
 329:	e8 ca 02 00 00       	call   5f8 <printf>
 32e:	83 c4 10             	add    $0x10,%esp
       exit();
 331:	e8 4b 01 00 00       	call   481 <exit>
     }

     int i=0;
 336:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 33d:	eb 1c                	jmp    35b <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 33f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 342:	8b 45 08             	mov    0x8(%ebp),%eax
 345:	01 d0                	add    %edx,%eax
 347:	0f b6 00             	movzbl (%eax),%eax
 34a:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 350:	8b 55 f4             	mov    -0xc(%ebp),%edx
 353:	01 ca                	add    %ecx,%edx
 355:	88 02                	mov    %al,(%edx)
	i++;
 357:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 35b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 35e:	8b 45 08             	mov    0x8(%ebp),%eax
 361:	01 d0                	add    %edx,%eax
 363:	0f b6 00             	movzbl (%eax),%eax
 366:	84 c0                	test   %al,%al
 368:	75 d5                	jne    33f <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 36a:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 370:	8b 45 f4             	mov    -0xc(%ebp),%eax
 373:	01 d0                	add    %edx,%eax
 375:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 378:	eb 5a                	jmp    3d4 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 37a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 37d:	83 ec 0c             	sub    $0xc,%esp
 380:	ff 75 08             	pushl  0x8(%ebp)
 383:	e8 9d fd ff ff       	call   125 <strlen>
 388:	83 c4 10             	add    $0x10,%esp
 38b:	29 c3                	sub    %eax,%ebx
 38d:	89 d8                	mov    %ebx,%eax
 38f:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 396:	ff 
 397:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 39d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3a0:	01 ca                	add    %ecx,%edx
 3a2:	88 02                	mov    %al,(%edx)
		i++;
 3a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 3a8:	83 ec 0c             	sub    $0xc,%esp
 3ab:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 3b1:	50                   	push   %eax
 3b2:	e8 6e fd ff ff       	call   125 <strlen>
 3b7:	83 c4 10             	add    $0x10,%esp
 3ba:	89 c3                	mov    %eax,%ebx
 3bc:	83 ec 0c             	sub    $0xc,%esp
 3bf:	ff 75 08             	pushl  0x8(%ebp)
 3c2:	e8 5e fd ff ff       	call   125 <strlen>
 3c7:	83 c4 10             	add    $0x10,%esp
 3ca:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 3cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3d0:	39 c2                	cmp    %eax,%edx
 3d2:	77 a6                	ja     37a <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3d4:	83 ec 04             	sub    $0x4,%esp
 3d7:	68 e8 03 00 00       	push   $0x3e8
 3dc:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 3e2:	50                   	push   %eax
 3e3:	ff 75 f0             	pushl  -0x10(%ebp)
 3e6:	e8 ae 00 00 00       	call   499 <read>
 3eb:	83 c4 10             	add    $0x10,%esp
 3ee:	85 c0                	test   %eax,%eax
 3f0:	7f b6                	jg     3a8 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 3f2:	83 ec 0c             	sub    $0xc,%esp
 3f5:	ff 75 f0             	pushl  -0x10(%ebp)
 3f8:	e8 ac 00 00 00       	call   4a9 <close>
 3fd:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 400:	83 ec 08             	sub    $0x8,%esp
 403:	68 02 02 00 00       	push   $0x202
 408:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 40b:	50                   	push   %eax
 40c:	e8 b0 00 00 00       	call   4c1 <open>
 411:	83 c4 10             	add    $0x10,%esp
 414:	89 45 f0             	mov    %eax,-0x10(%ebp)
 417:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 41b:	79 1b                	jns    438 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 41d:	83 ec 04             	sub    $0x4,%esp
 420:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 423:	50                   	push   %eax
 424:	68 e4 09 00 00       	push   $0x9e4
 429:	6a 01                	push   $0x1
 42b:	e8 c8 01 00 00       	call   5f8 <printf>
 430:	83 c4 10             	add    $0x10,%esp
       exit();
 433:	e8 49 00 00 00       	call   481 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 438:	83 ec 04             	sub    $0x4,%esp
 43b:	68 e8 03 00 00       	push   $0x3e8
 440:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 446:	50                   	push   %eax
 447:	ff 75 f0             	pushl  -0x10(%ebp)
 44a:	e8 52 00 00 00       	call   4a1 <write>
 44f:	83 c4 10             	add    $0x10,%esp
 452:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 457:	74 1a                	je     473 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 459:	83 ec 04             	sub    $0x4,%esp
 45c:	ff 75 f4             	pushl  -0xc(%ebp)
 45f:	68 00 0a 00 00       	push   $0xa00
 464:	6a 01                	push   $0x1
 466:	e8 8d 01 00 00       	call   5f8 <printf>
 46b:	83 c4 10             	add    $0x10,%esp
       exit();
 46e:	e8 0e 00 00 00       	call   481 <exit>
     }
    
}
 473:	90                   	nop
 474:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 477:	c9                   	leave  
 478:	c3                   	ret    

00000479 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 479:	b8 01 00 00 00       	mov    $0x1,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <exit>:
SYSCALL(exit)
 481:	b8 02 00 00 00       	mov    $0x2,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <wait>:
SYSCALL(wait)
 489:	b8 03 00 00 00       	mov    $0x3,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <pipe>:
SYSCALL(pipe)
 491:	b8 04 00 00 00       	mov    $0x4,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <read>:
SYSCALL(read)
 499:	b8 05 00 00 00       	mov    $0x5,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <write>:
SYSCALL(write)
 4a1:	b8 10 00 00 00       	mov    $0x10,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <close>:
SYSCALL(close)
 4a9:	b8 15 00 00 00       	mov    $0x15,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <kill>:
SYSCALL(kill)
 4b1:	b8 06 00 00 00       	mov    $0x6,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <exec>:
SYSCALL(exec)
 4b9:	b8 07 00 00 00       	mov    $0x7,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <open>:
SYSCALL(open)
 4c1:	b8 0f 00 00 00       	mov    $0xf,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <mknod>:
SYSCALL(mknod)
 4c9:	b8 11 00 00 00       	mov    $0x11,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <unlink>:
SYSCALL(unlink)
 4d1:	b8 12 00 00 00       	mov    $0x12,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    

000004d9 <fstat>:
SYSCALL(fstat)
 4d9:	b8 08 00 00 00       	mov    $0x8,%eax
 4de:	cd 40                	int    $0x40
 4e0:	c3                   	ret    

000004e1 <link>:
SYSCALL(link)
 4e1:	b8 13 00 00 00       	mov    $0x13,%eax
 4e6:	cd 40                	int    $0x40
 4e8:	c3                   	ret    

000004e9 <mkdir>:
SYSCALL(mkdir)
 4e9:	b8 14 00 00 00       	mov    $0x14,%eax
 4ee:	cd 40                	int    $0x40
 4f0:	c3                   	ret    

000004f1 <chdir>:
SYSCALL(chdir)
 4f1:	b8 09 00 00 00       	mov    $0x9,%eax
 4f6:	cd 40                	int    $0x40
 4f8:	c3                   	ret    

000004f9 <dup>:
SYSCALL(dup)
 4f9:	b8 0a 00 00 00       	mov    $0xa,%eax
 4fe:	cd 40                	int    $0x40
 500:	c3                   	ret    

00000501 <getpid>:
SYSCALL(getpid)
 501:	b8 0b 00 00 00       	mov    $0xb,%eax
 506:	cd 40                	int    $0x40
 508:	c3                   	ret    

00000509 <sbrk>:
SYSCALL(sbrk)
 509:	b8 0c 00 00 00       	mov    $0xc,%eax
 50e:	cd 40                	int    $0x40
 510:	c3                   	ret    

00000511 <sleep>:
SYSCALL(sleep)
 511:	b8 0d 00 00 00       	mov    $0xd,%eax
 516:	cd 40                	int    $0x40
 518:	c3                   	ret    

00000519 <uptime>:
SYSCALL(uptime)
 519:	b8 0e 00 00 00       	mov    $0xe,%eax
 51e:	cd 40                	int    $0x40
 520:	c3                   	ret    

00000521 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 521:	55                   	push   %ebp
 522:	89 e5                	mov    %esp,%ebp
 524:	83 ec 18             	sub    $0x18,%esp
 527:	8b 45 0c             	mov    0xc(%ebp),%eax
 52a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 52d:	83 ec 04             	sub    $0x4,%esp
 530:	6a 01                	push   $0x1
 532:	8d 45 f4             	lea    -0xc(%ebp),%eax
 535:	50                   	push   %eax
 536:	ff 75 08             	pushl  0x8(%ebp)
 539:	e8 63 ff ff ff       	call   4a1 <write>
 53e:	83 c4 10             	add    $0x10,%esp
}
 541:	90                   	nop
 542:	c9                   	leave  
 543:	c3                   	ret    

00000544 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 544:	55                   	push   %ebp
 545:	89 e5                	mov    %esp,%ebp
 547:	53                   	push   %ebx
 548:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 54b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 552:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 556:	74 17                	je     56f <printint+0x2b>
 558:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 55c:	79 11                	jns    56f <printint+0x2b>
    neg = 1;
 55e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 565:	8b 45 0c             	mov    0xc(%ebp),%eax
 568:	f7 d8                	neg    %eax
 56a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 56d:	eb 06                	jmp    575 <printint+0x31>
  } else {
    x = xx;
 56f:	8b 45 0c             	mov    0xc(%ebp),%eax
 572:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 575:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 57c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 57f:	8d 41 01             	lea    0x1(%ecx),%eax
 582:	89 45 f4             	mov    %eax,-0xc(%ebp)
 585:	8b 5d 10             	mov    0x10(%ebp),%ebx
 588:	8b 45 ec             	mov    -0x14(%ebp),%eax
 58b:	ba 00 00 00 00       	mov    $0x0,%edx
 590:	f7 f3                	div    %ebx
 592:	89 d0                	mov    %edx,%eax
 594:	0f b6 80 9c 0c 00 00 	movzbl 0xc9c(%eax),%eax
 59b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 59f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a5:	ba 00 00 00 00       	mov    $0x0,%edx
 5aa:	f7 f3                	div    %ebx
 5ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b3:	75 c7                	jne    57c <printint+0x38>
  if(neg)
 5b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5b9:	74 2d                	je     5e8 <printint+0xa4>
    buf[i++] = '-';
 5bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5be:	8d 50 01             	lea    0x1(%eax),%edx
 5c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5c9:	eb 1d                	jmp    5e8 <printint+0xa4>
    putc(fd, buf[i]);
 5cb:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d1:	01 d0                	add    %edx,%eax
 5d3:	0f b6 00             	movzbl (%eax),%eax
 5d6:	0f be c0             	movsbl %al,%eax
 5d9:	83 ec 08             	sub    $0x8,%esp
 5dc:	50                   	push   %eax
 5dd:	ff 75 08             	pushl  0x8(%ebp)
 5e0:	e8 3c ff ff ff       	call   521 <putc>
 5e5:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5e8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5f0:	79 d9                	jns    5cb <printint+0x87>
    putc(fd, buf[i]);
}
 5f2:	90                   	nop
 5f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5f6:	c9                   	leave  
 5f7:	c3                   	ret    

000005f8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5f8:	55                   	push   %ebp
 5f9:	89 e5                	mov    %esp,%ebp
 5fb:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 605:	8d 45 0c             	lea    0xc(%ebp),%eax
 608:	83 c0 04             	add    $0x4,%eax
 60b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 60e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 615:	e9 59 01 00 00       	jmp    773 <printf+0x17b>
    c = fmt[i] & 0xff;
 61a:	8b 55 0c             	mov    0xc(%ebp),%edx
 61d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 620:	01 d0                	add    %edx,%eax
 622:	0f b6 00             	movzbl (%eax),%eax
 625:	0f be c0             	movsbl %al,%eax
 628:	25 ff 00 00 00       	and    $0xff,%eax
 62d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 630:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 634:	75 2c                	jne    662 <printf+0x6a>
      if(c == '%'){
 636:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 63a:	75 0c                	jne    648 <printf+0x50>
        state = '%';
 63c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 643:	e9 27 01 00 00       	jmp    76f <printf+0x177>
      } else {
        putc(fd, c);
 648:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64b:	0f be c0             	movsbl %al,%eax
 64e:	83 ec 08             	sub    $0x8,%esp
 651:	50                   	push   %eax
 652:	ff 75 08             	pushl  0x8(%ebp)
 655:	e8 c7 fe ff ff       	call   521 <putc>
 65a:	83 c4 10             	add    $0x10,%esp
 65d:	e9 0d 01 00 00       	jmp    76f <printf+0x177>
      }
    } else if(state == '%'){
 662:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 666:	0f 85 03 01 00 00    	jne    76f <printf+0x177>
      if(c == 'd'){
 66c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 670:	75 1e                	jne    690 <printf+0x98>
        printint(fd, *ap, 10, 1);
 672:	8b 45 e8             	mov    -0x18(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	6a 01                	push   $0x1
 679:	6a 0a                	push   $0xa
 67b:	50                   	push   %eax
 67c:	ff 75 08             	pushl  0x8(%ebp)
 67f:	e8 c0 fe ff ff       	call   544 <printint>
 684:	83 c4 10             	add    $0x10,%esp
        ap++;
 687:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68b:	e9 d8 00 00 00       	jmp    768 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 690:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 694:	74 06                	je     69c <printf+0xa4>
 696:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 69a:	75 1e                	jne    6ba <printf+0xc2>
        printint(fd, *ap, 16, 0);
 69c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69f:	8b 00                	mov    (%eax),%eax
 6a1:	6a 00                	push   $0x0
 6a3:	6a 10                	push   $0x10
 6a5:	50                   	push   %eax
 6a6:	ff 75 08             	pushl  0x8(%ebp)
 6a9:	e8 96 fe ff ff       	call   544 <printint>
 6ae:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b5:	e9 ae 00 00 00       	jmp    768 <printf+0x170>
      } else if(c == 's'){
 6ba:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6be:	75 43                	jne    703 <printf+0x10b>
        s = (char*)*ap;
 6c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c3:	8b 00                	mov    (%eax),%eax
 6c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6c8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6d0:	75 25                	jne    6f7 <printf+0xff>
          s = "(null)";
 6d2:	c7 45 f4 24 0a 00 00 	movl   $0xa24,-0xc(%ebp)
        while(*s != 0){
 6d9:	eb 1c                	jmp    6f7 <printf+0xff>
          putc(fd, *s);
 6db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6de:	0f b6 00             	movzbl (%eax),%eax
 6e1:	0f be c0             	movsbl %al,%eax
 6e4:	83 ec 08             	sub    $0x8,%esp
 6e7:	50                   	push   %eax
 6e8:	ff 75 08             	pushl  0x8(%ebp)
 6eb:	e8 31 fe ff ff       	call   521 <putc>
 6f0:	83 c4 10             	add    $0x10,%esp
          s++;
 6f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fa:	0f b6 00             	movzbl (%eax),%eax
 6fd:	84 c0                	test   %al,%al
 6ff:	75 da                	jne    6db <printf+0xe3>
 701:	eb 65                	jmp    768 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 703:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 707:	75 1d                	jne    726 <printf+0x12e>
        putc(fd, *ap);
 709:	8b 45 e8             	mov    -0x18(%ebp),%eax
 70c:	8b 00                	mov    (%eax),%eax
 70e:	0f be c0             	movsbl %al,%eax
 711:	83 ec 08             	sub    $0x8,%esp
 714:	50                   	push   %eax
 715:	ff 75 08             	pushl  0x8(%ebp)
 718:	e8 04 fe ff ff       	call   521 <putc>
 71d:	83 c4 10             	add    $0x10,%esp
        ap++;
 720:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 724:	eb 42                	jmp    768 <printf+0x170>
      } else if(c == '%'){
 726:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 72a:	75 17                	jne    743 <printf+0x14b>
        putc(fd, c);
 72c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 72f:	0f be c0             	movsbl %al,%eax
 732:	83 ec 08             	sub    $0x8,%esp
 735:	50                   	push   %eax
 736:	ff 75 08             	pushl  0x8(%ebp)
 739:	e8 e3 fd ff ff       	call   521 <putc>
 73e:	83 c4 10             	add    $0x10,%esp
 741:	eb 25                	jmp    768 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 743:	83 ec 08             	sub    $0x8,%esp
 746:	6a 25                	push   $0x25
 748:	ff 75 08             	pushl  0x8(%ebp)
 74b:	e8 d1 fd ff ff       	call   521 <putc>
 750:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 753:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 756:	0f be c0             	movsbl %al,%eax
 759:	83 ec 08             	sub    $0x8,%esp
 75c:	50                   	push   %eax
 75d:	ff 75 08             	pushl  0x8(%ebp)
 760:	e8 bc fd ff ff       	call   521 <putc>
 765:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 768:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 76f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 773:	8b 55 0c             	mov    0xc(%ebp),%edx
 776:	8b 45 f0             	mov    -0x10(%ebp),%eax
 779:	01 d0                	add    %edx,%eax
 77b:	0f b6 00             	movzbl (%eax),%eax
 77e:	84 c0                	test   %al,%al
 780:	0f 85 94 fe ff ff    	jne    61a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 786:	90                   	nop
 787:	c9                   	leave  
 788:	c3                   	ret    

00000789 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 789:	55                   	push   %ebp
 78a:	89 e5                	mov    %esp,%ebp
 78c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78f:	8b 45 08             	mov    0x8(%ebp),%eax
 792:	83 e8 08             	sub    $0x8,%eax
 795:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 798:	a1 b8 0c 00 00       	mov    0xcb8,%eax
 79d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a0:	eb 24                	jmp    7c6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 00                	mov    (%eax),%eax
 7a7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7aa:	77 12                	ja     7be <free+0x35>
 7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7af:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b2:	77 24                	ja     7d8 <free+0x4f>
 7b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b7:	8b 00                	mov    (%eax),%eax
 7b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7bc:	77 1a                	ja     7d8 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c1:	8b 00                	mov    (%eax),%eax
 7c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cc:	76 d4                	jbe    7a2 <free+0x19>
 7ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d6:	76 ca                	jbe    7a2 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7db:	8b 40 04             	mov    0x4(%eax),%eax
 7de:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e8:	01 c2                	add    %eax,%edx
 7ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ed:	8b 00                	mov    (%eax),%eax
 7ef:	39 c2                	cmp    %eax,%edx
 7f1:	75 24                	jne    817 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f6:	8b 50 04             	mov    0x4(%eax),%edx
 7f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fc:	8b 00                	mov    (%eax),%eax
 7fe:	8b 40 04             	mov    0x4(%eax),%eax
 801:	01 c2                	add    %eax,%edx
 803:	8b 45 f8             	mov    -0x8(%ebp),%eax
 806:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 809:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80c:	8b 00                	mov    (%eax),%eax
 80e:	8b 10                	mov    (%eax),%edx
 810:	8b 45 f8             	mov    -0x8(%ebp),%eax
 813:	89 10                	mov    %edx,(%eax)
 815:	eb 0a                	jmp    821 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 817:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81a:	8b 10                	mov    (%eax),%edx
 81c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 821:	8b 45 fc             	mov    -0x4(%ebp),%eax
 824:	8b 40 04             	mov    0x4(%eax),%eax
 827:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 82e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 831:	01 d0                	add    %edx,%eax
 833:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 836:	75 20                	jne    858 <free+0xcf>
    p->s.size += bp->s.size;
 838:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83b:	8b 50 04             	mov    0x4(%eax),%edx
 83e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 841:	8b 40 04             	mov    0x4(%eax),%eax
 844:	01 c2                	add    %eax,%edx
 846:	8b 45 fc             	mov    -0x4(%ebp),%eax
 849:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 84c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84f:	8b 10                	mov    (%eax),%edx
 851:	8b 45 fc             	mov    -0x4(%ebp),%eax
 854:	89 10                	mov    %edx,(%eax)
 856:	eb 08                	jmp    860 <free+0xd7>
  } else
    p->s.ptr = bp;
 858:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 85e:	89 10                	mov    %edx,(%eax)
  freep = p;
 860:	8b 45 fc             	mov    -0x4(%ebp),%eax
 863:	a3 b8 0c 00 00       	mov    %eax,0xcb8
}
 868:	90                   	nop
 869:	c9                   	leave  
 86a:	c3                   	ret    

0000086b <morecore>:

static Header*
morecore(uint nu)
{
 86b:	55                   	push   %ebp
 86c:	89 e5                	mov    %esp,%ebp
 86e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 871:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 878:	77 07                	ja     881 <morecore+0x16>
    nu = 4096;
 87a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 881:	8b 45 08             	mov    0x8(%ebp),%eax
 884:	c1 e0 03             	shl    $0x3,%eax
 887:	83 ec 0c             	sub    $0xc,%esp
 88a:	50                   	push   %eax
 88b:	e8 79 fc ff ff       	call   509 <sbrk>
 890:	83 c4 10             	add    $0x10,%esp
 893:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 896:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 89a:	75 07                	jne    8a3 <morecore+0x38>
    return 0;
 89c:	b8 00 00 00 00       	mov    $0x0,%eax
 8a1:	eb 26                	jmp    8c9 <morecore+0x5e>
  hp = (Header*)p;
 8a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ac:	8b 55 08             	mov    0x8(%ebp),%edx
 8af:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b5:	83 c0 08             	add    $0x8,%eax
 8b8:	83 ec 0c             	sub    $0xc,%esp
 8bb:	50                   	push   %eax
 8bc:	e8 c8 fe ff ff       	call   789 <free>
 8c1:	83 c4 10             	add    $0x10,%esp
  return freep;
 8c4:	a1 b8 0c 00 00       	mov    0xcb8,%eax
}
 8c9:	c9                   	leave  
 8ca:	c3                   	ret    

000008cb <malloc>:

void*
malloc(uint nbytes)
{
 8cb:	55                   	push   %ebp
 8cc:	89 e5                	mov    %esp,%ebp
 8ce:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d1:	8b 45 08             	mov    0x8(%ebp),%eax
 8d4:	83 c0 07             	add    $0x7,%eax
 8d7:	c1 e8 03             	shr    $0x3,%eax
 8da:	83 c0 01             	add    $0x1,%eax
 8dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8e0:	a1 b8 0c 00 00       	mov    0xcb8,%eax
 8e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8ec:	75 23                	jne    911 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8ee:	c7 45 f0 b0 0c 00 00 	movl   $0xcb0,-0x10(%ebp)
 8f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f8:	a3 b8 0c 00 00       	mov    %eax,0xcb8
 8fd:	a1 b8 0c 00 00       	mov    0xcb8,%eax
 902:	a3 b0 0c 00 00       	mov    %eax,0xcb0
    base.s.size = 0;
 907:	c7 05 b4 0c 00 00 00 	movl   $0x0,0xcb4
 90e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 911:	8b 45 f0             	mov    -0x10(%ebp),%eax
 914:	8b 00                	mov    (%eax),%eax
 916:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 919:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91c:	8b 40 04             	mov    0x4(%eax),%eax
 91f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 922:	72 4d                	jb     971 <malloc+0xa6>
      if(p->s.size == nunits)
 924:	8b 45 f4             	mov    -0xc(%ebp),%eax
 927:	8b 40 04             	mov    0x4(%eax),%eax
 92a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 92d:	75 0c                	jne    93b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 92f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 932:	8b 10                	mov    (%eax),%edx
 934:	8b 45 f0             	mov    -0x10(%ebp),%eax
 937:	89 10                	mov    %edx,(%eax)
 939:	eb 26                	jmp    961 <malloc+0x96>
      else {
        p->s.size -= nunits;
 93b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93e:	8b 40 04             	mov    0x4(%eax),%eax
 941:	2b 45 ec             	sub    -0x14(%ebp),%eax
 944:	89 c2                	mov    %eax,%edx
 946:	8b 45 f4             	mov    -0xc(%ebp),%eax
 949:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 94c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94f:	8b 40 04             	mov    0x4(%eax),%eax
 952:	c1 e0 03             	shl    $0x3,%eax
 955:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 958:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 95e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 961:	8b 45 f0             	mov    -0x10(%ebp),%eax
 964:	a3 b8 0c 00 00       	mov    %eax,0xcb8
      return (void*)(p + 1);
 969:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96c:	83 c0 08             	add    $0x8,%eax
 96f:	eb 3b                	jmp    9ac <malloc+0xe1>
    }
    if(p == freep)
 971:	a1 b8 0c 00 00       	mov    0xcb8,%eax
 976:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 979:	75 1e                	jne    999 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 97b:	83 ec 0c             	sub    $0xc,%esp
 97e:	ff 75 ec             	pushl  -0x14(%ebp)
 981:	e8 e5 fe ff ff       	call   86b <morecore>
 986:	83 c4 10             	add    $0x10,%esp
 989:	89 45 f4             	mov    %eax,-0xc(%ebp)
 98c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 990:	75 07                	jne    999 <malloc+0xce>
        return 0;
 992:	b8 00 00 00 00       	mov    $0x0,%eax
 997:	eb 13                	jmp    9ac <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 999:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 99f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a2:	8b 00                	mov    (%eax),%eax
 9a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9a7:	e9 6d ff ff ff       	jmp    919 <malloc+0x4e>
}
 9ac:	c9                   	leave  
 9ad:	c3                   	ret    
