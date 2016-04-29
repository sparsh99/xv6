
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	pushl  0xc(%ebp)
   c:	e8 97 01 00 00       	call   1a8 <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	pushl  0xc(%ebp)
  1b:	ff 75 08             	pushl  0x8(%ebp)
  1e:	e8 01 05 00 00       	call   524 <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	90                   	nop
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	55                   	push   %ebp
  2a:	89 e5                	mov    %esp,%ebp
  2c:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	68 a4 05 00 00       	push   $0x5a4
  37:	6a 01                	push   $0x1
  39:	e8 c2 ff ff ff       	call   0 <printf>
  3e:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  48:	eb 1d                	jmp    67 <forktest+0x3e>
    pid = fork();
  4a:	e8 ad 04 00 00       	call   4fc <fork>
  4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  56:	78 1a                	js     72 <forktest+0x49>
      break;
    if(pid == 0)
  58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5c:	75 05                	jne    63 <forktest+0x3a>
      exit();
  5e:	e8 a1 04 00 00       	call   504 <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  67:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  6e:	7e da                	jle    4a <forktest+0x21>
  70:	eb 01                	jmp    73 <forktest+0x4a>
    pid = fork();
    if(pid < 0)
      break;
  72:	90                   	nop
    if(pid == 0)
      exit();
  }
  
  if(n == N){
  73:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  7a:	75 40                	jne    bc <forktest+0x93>
    printf(1, "fork claimed to work N times!\n", N);
  7c:	83 ec 04             	sub    $0x4,%esp
  7f:	68 e8 03 00 00       	push   $0x3e8
  84:	68 b0 05 00 00       	push   $0x5b0
  89:	6a 01                	push   $0x1
  8b:	e8 70 ff ff ff       	call   0 <printf>
  90:	83 c4 10             	add    $0x10,%esp
    exit();
  93:	e8 6c 04 00 00       	call   504 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
  98:	e8 6f 04 00 00       	call   50c <wait>
  9d:	85 c0                	test   %eax,%eax
  9f:	79 17                	jns    b8 <forktest+0x8f>
      printf(1, "wait stopped early\n");
  a1:	83 ec 08             	sub    $0x8,%esp
  a4:	68 cf 05 00 00       	push   $0x5cf
  a9:	6a 01                	push   $0x1
  ab:	e8 50 ff ff ff       	call   0 <printf>
  b0:	83 c4 10             	add    $0x10,%esp
      exit();
  b3:	e8 4c 04 00 00       	call   504 <exit>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }
  
  for(; n > 0; n--){
  b8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  c0:	7f d6                	jg     98 <forktest+0x6f>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
  c2:	e8 45 04 00 00       	call   50c <wait>
  c7:	83 f8 ff             	cmp    $0xffffffff,%eax
  ca:	74 17                	je     e3 <forktest+0xba>
    printf(1, "wait got too many\n");
  cc:	83 ec 08             	sub    $0x8,%esp
  cf:	68 e3 05 00 00       	push   $0x5e3
  d4:	6a 01                	push   $0x1
  d6:	e8 25 ff ff ff       	call   0 <printf>
  db:	83 c4 10             	add    $0x10,%esp
    exit();
  de:	e8 21 04 00 00       	call   504 <exit>
  }
  
  printf(1, "fork test OK\n");
  e3:	83 ec 08             	sub    $0x8,%esp
  e6:	68 f6 05 00 00       	push   $0x5f6
  eb:	6a 01                	push   $0x1
  ed:	e8 0e ff ff ff       	call   0 <printf>
  f2:	83 c4 10             	add    $0x10,%esp
}
  f5:	90                   	nop
  f6:	c9                   	leave  
  f7:	c3                   	ret    

000000f8 <main>:

int
main(void)
{
  f8:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  fc:	83 e4 f0             	and    $0xfffffff0,%esp
  ff:	ff 71 fc             	pushl  -0x4(%ecx)
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	51                   	push   %ecx
 106:	83 ec 04             	sub    $0x4,%esp
  forktest();
 109:	e8 1b ff ff ff       	call   29 <forktest>
  exit();
 10e:	e8 f1 03 00 00       	call   504 <exit>

00000113 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp
 116:	57                   	push   %edi
 117:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 118:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11b:	8b 55 10             	mov    0x10(%ebp),%edx
 11e:	8b 45 0c             	mov    0xc(%ebp),%eax
 121:	89 cb                	mov    %ecx,%ebx
 123:	89 df                	mov    %ebx,%edi
 125:	89 d1                	mov    %edx,%ecx
 127:	fc                   	cld    
 128:	f3 aa                	rep stos %al,%es:(%edi)
 12a:	89 ca                	mov    %ecx,%edx
 12c:	89 fb                	mov    %edi,%ebx
 12e:	89 5d 08             	mov    %ebx,0x8(%ebp)
 131:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 134:	90                   	nop
 135:	5b                   	pop    %ebx
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    

00000139 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 145:	90                   	nop
 146:	8b 45 08             	mov    0x8(%ebp),%eax
 149:	8d 50 01             	lea    0x1(%eax),%edx
 14c:	89 55 08             	mov    %edx,0x8(%ebp)
 14f:	8b 55 0c             	mov    0xc(%ebp),%edx
 152:	8d 4a 01             	lea    0x1(%edx),%ecx
 155:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 158:	0f b6 12             	movzbl (%edx),%edx
 15b:	88 10                	mov    %dl,(%eax)
 15d:	0f b6 00             	movzbl (%eax),%eax
 160:	84 c0                	test   %al,%al
 162:	75 e2                	jne    146 <strcpy+0xd>
    ;
  return os;
 164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 167:	c9                   	leave  
 168:	c3                   	ret    

00000169 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 169:	55                   	push   %ebp
 16a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 16c:	eb 08                	jmp    176 <strcmp+0xd>
    p++, q++;
 16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 172:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	84 c0                	test   %al,%al
 17e:	74 10                	je     190 <strcmp+0x27>
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 10             	movzbl (%eax),%edx
 186:	8b 45 0c             	mov    0xc(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	38 c2                	cmp    %al,%dl
 18e:	74 de                	je     16e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	0f b6 d0             	movzbl %al,%edx
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	0f b6 c0             	movzbl %al,%eax
 1a2:	29 c2                	sub    %eax,%edx
 1a4:	89 d0                	mov    %edx,%eax
}
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    

000001a8 <strlen>:

uint
strlen(char *s)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b5:	eb 04                	jmp    1bb <strlen+0x13>
 1b7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	01 d0                	add    %edx,%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	75 ed                	jne    1b7 <strlen+0xf>
    ;
  return n;
 1ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1cd:	c9                   	leave  
 1ce:	c3                   	ret    

000001cf <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1d2:	8b 45 10             	mov    0x10(%ebp),%eax
 1d5:	50                   	push   %eax
 1d6:	ff 75 0c             	pushl  0xc(%ebp)
 1d9:	ff 75 08             	pushl  0x8(%ebp)
 1dc:	e8 32 ff ff ff       	call   113 <stosb>
 1e1:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <strchr>:

char*
strchr(const char *s, char c)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 04             	sub    $0x4,%esp
 1ef:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1f5:	eb 14                	jmp    20b <strchr+0x22>
    if(*s == c)
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	0f b6 00             	movzbl (%eax),%eax
 1fd:	3a 45 fc             	cmp    -0x4(%ebp),%al
 200:	75 05                	jne    207 <strchr+0x1e>
      return (char*)s;
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	eb 13                	jmp    21a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 207:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	0f b6 00             	movzbl (%eax),%eax
 211:	84 c0                	test   %al,%al
 213:	75 e2                	jne    1f7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 215:	b8 00 00 00 00       	mov    $0x0,%eax
}
 21a:	c9                   	leave  
 21b:	c3                   	ret    

0000021c <gets>:

char*
gets(char *buf, int max)
{
 21c:	55                   	push   %ebp
 21d:	89 e5                	mov    %esp,%ebp
 21f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 222:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 229:	eb 42                	jmp    26d <gets+0x51>
    cc = read(0, &c, 1);
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	6a 01                	push   $0x1
 230:	8d 45 ef             	lea    -0x11(%ebp),%eax
 233:	50                   	push   %eax
 234:	6a 00                	push   $0x0
 236:	e8 e1 02 00 00       	call   51c <read>
 23b:	83 c4 10             	add    $0x10,%esp
 23e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 241:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 245:	7e 33                	jle    27a <gets+0x5e>
      break;
    buf[i++] = c;
 247:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24a:	8d 50 01             	lea    0x1(%eax),%edx
 24d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 250:	89 c2                	mov    %eax,%edx
 252:	8b 45 08             	mov    0x8(%ebp),%eax
 255:	01 c2                	add    %eax,%edx
 257:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 25d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 261:	3c 0a                	cmp    $0xa,%al
 263:	74 16                	je     27b <gets+0x5f>
 265:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 269:	3c 0d                	cmp    $0xd,%al
 26b:	74 0e                	je     27b <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 270:	83 c0 01             	add    $0x1,%eax
 273:	3b 45 0c             	cmp    0xc(%ebp),%eax
 276:	7c b3                	jl     22b <gets+0xf>
 278:	eb 01                	jmp    27b <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 27a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 27b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	01 d0                	add    %edx,%eax
 283:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 286:	8b 45 08             	mov    0x8(%ebp),%eax
}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <stat>:

int
stat(char *n, struct stat *st)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	83 ec 08             	sub    $0x8,%esp
 294:	6a 00                	push   $0x0
 296:	ff 75 08             	pushl  0x8(%ebp)
 299:	e8 a6 02 00 00       	call   544 <open>
 29e:	83 c4 10             	add    $0x10,%esp
 2a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a8:	79 07                	jns    2b1 <stat+0x26>
    return -1;
 2aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2af:	eb 25                	jmp    2d6 <stat+0x4b>
  r = fstat(fd, st);
 2b1:	83 ec 08             	sub    $0x8,%esp
 2b4:	ff 75 0c             	pushl  0xc(%ebp)
 2b7:	ff 75 f4             	pushl  -0xc(%ebp)
 2ba:	e8 9d 02 00 00       	call   55c <fstat>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c5:	83 ec 0c             	sub    $0xc,%esp
 2c8:	ff 75 f4             	pushl  -0xc(%ebp)
 2cb:	e8 5c 02 00 00       	call   52c <close>
 2d0:	83 c4 10             	add    $0x10,%esp
  return r;
 2d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2d6:	c9                   	leave  
 2d7:	c3                   	ret    

000002d8 <atoi>:

int
atoi(const char *s)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e5:	eb 25                	jmp    30c <atoi+0x34>
    n = n*10 + *s++ - '0';
 2e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2ea:	89 d0                	mov    %edx,%eax
 2ec:	c1 e0 02             	shl    $0x2,%eax
 2ef:	01 d0                	add    %edx,%eax
 2f1:	01 c0                	add    %eax,%eax
 2f3:	89 c1                	mov    %eax,%ecx
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
 2f8:	8d 50 01             	lea    0x1(%eax),%edx
 2fb:	89 55 08             	mov    %edx,0x8(%ebp)
 2fe:	0f b6 00             	movzbl (%eax),%eax
 301:	0f be c0             	movsbl %al,%eax
 304:	01 c8                	add    %ecx,%eax
 306:	83 e8 30             	sub    $0x30,%eax
 309:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	0f b6 00             	movzbl (%eax),%eax
 312:	3c 2f                	cmp    $0x2f,%al
 314:	7e 0a                	jle    320 <atoi+0x48>
 316:	8b 45 08             	mov    0x8(%ebp),%eax
 319:	0f b6 00             	movzbl (%eax),%eax
 31c:	3c 39                	cmp    $0x39,%al
 31e:	7e c7                	jle    2e7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 320:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 323:	c9                   	leave  
 324:	c3                   	ret    

00000325 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 325:	55                   	push   %ebp
 326:	89 e5                	mov    %esp,%ebp
 328:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 331:	8b 45 0c             	mov    0xc(%ebp),%eax
 334:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 337:	eb 17                	jmp    350 <memmove+0x2b>
    *dst++ = *src++;
 339:	8b 45 fc             	mov    -0x4(%ebp),%eax
 33c:	8d 50 01             	lea    0x1(%eax),%edx
 33f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 342:	8b 55 f8             	mov    -0x8(%ebp),%edx
 345:	8d 4a 01             	lea    0x1(%edx),%ecx
 348:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 34b:	0f b6 12             	movzbl (%edx),%edx
 34e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 350:	8b 45 10             	mov    0x10(%ebp),%eax
 353:	8d 50 ff             	lea    -0x1(%eax),%edx
 356:	89 55 10             	mov    %edx,0x10(%ebp)
 359:	85 c0                	test   %eax,%eax
 35b:	7f dc                	jg     339 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 35d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 360:	c9                   	leave  
 361:	c3                   	ret    

00000362 <historyAdd>:

void
historyAdd(char *buf1){
 362:	55                   	push   %ebp
 363:	89 e5                	mov    %esp,%ebp
 365:	53                   	push   %ebx
 366:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 36c:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 373:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 37a:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 380:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 384:	83 ec 08             	sub    $0x8,%esp
 387:	6a 00                	push   $0x0
 389:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 38c:	50                   	push   %eax
 38d:	e8 b2 01 00 00       	call   544 <open>
 392:	83 c4 10             	add    $0x10,%esp
 395:	89 45 f0             	mov    %eax,-0x10(%ebp)
 398:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 39c:	79 1b                	jns    3b9 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 39e:	83 ec 04             	sub    $0x4,%esp
 3a1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3a4:	50                   	push   %eax
 3a5:	68 04 06 00 00       	push   $0x604
 3aa:	6a 01                	push   $0x1
 3ac:	e8 4f fc ff ff       	call   0 <printf>
 3b1:	83 c4 10             	add    $0x10,%esp
       exit();
 3b4:	e8 4b 01 00 00       	call   504 <exit>
     }

     int i=0;
 3b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 3c0:	eb 1c                	jmp    3de <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 3c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3c5:	8b 45 08             	mov    0x8(%ebp),%eax
 3c8:	01 d0                	add    %edx,%eax
 3ca:	0f b6 00             	movzbl (%eax),%eax
 3cd:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 3d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3d6:	01 ca                	add    %ecx,%edx
 3d8:	88 02                	mov    %al,(%edx)
	i++;
 3da:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 3de:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3e1:	8b 45 08             	mov    0x8(%ebp),%eax
 3e4:	01 d0                	add    %edx,%eax
 3e6:	0f b6 00             	movzbl (%eax),%eax
 3e9:	84 c0                	test   %al,%al
 3eb:	75 d5                	jne    3c2 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 3ed:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 3f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f6:	01 d0                	add    %edx,%eax
 3f8:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3fb:	eb 5a                	jmp    457 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 3fd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 400:	83 ec 0c             	sub    $0xc,%esp
 403:	ff 75 08             	pushl  0x8(%ebp)
 406:	e8 9d fd ff ff       	call   1a8 <strlen>
 40b:	83 c4 10             	add    $0x10,%esp
 40e:	29 c3                	sub    %eax,%ebx
 410:	89 d8                	mov    %ebx,%eax
 412:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 419:	ff 
 41a:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 420:	8b 55 f4             	mov    -0xc(%ebp),%edx
 423:	01 ca                	add    %ecx,%edx
 425:	88 02                	mov    %al,(%edx)
		i++;
 427:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 42b:	83 ec 0c             	sub    $0xc,%esp
 42e:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 434:	50                   	push   %eax
 435:	e8 6e fd ff ff       	call   1a8 <strlen>
 43a:	83 c4 10             	add    $0x10,%esp
 43d:	89 c3                	mov    %eax,%ebx
 43f:	83 ec 0c             	sub    $0xc,%esp
 442:	ff 75 08             	pushl  0x8(%ebp)
 445:	e8 5e fd ff ff       	call   1a8 <strlen>
 44a:	83 c4 10             	add    $0x10,%esp
 44d:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 450:	8b 45 f4             	mov    -0xc(%ebp),%eax
 453:	39 c2                	cmp    %eax,%edx
 455:	77 a6                	ja     3fd <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 457:	83 ec 04             	sub    $0x4,%esp
 45a:	68 e8 03 00 00       	push   $0x3e8
 45f:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 465:	50                   	push   %eax
 466:	ff 75 f0             	pushl  -0x10(%ebp)
 469:	e8 ae 00 00 00       	call   51c <read>
 46e:	83 c4 10             	add    $0x10,%esp
 471:	85 c0                	test   %eax,%eax
 473:	7f b6                	jg     42b <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 475:	83 ec 0c             	sub    $0xc,%esp
 478:	ff 75 f0             	pushl  -0x10(%ebp)
 47b:	e8 ac 00 00 00       	call   52c <close>
 480:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 483:	83 ec 08             	sub    $0x8,%esp
 486:	68 02 02 00 00       	push   $0x202
 48b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 48e:	50                   	push   %eax
 48f:	e8 b0 00 00 00       	call   544 <open>
 494:	83 c4 10             	add    $0x10,%esp
 497:	89 45 f0             	mov    %eax,-0x10(%ebp)
 49a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49e:	79 1b                	jns    4bb <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 4a0:	83 ec 04             	sub    $0x4,%esp
 4a3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4a6:	50                   	push   %eax
 4a7:	68 04 06 00 00       	push   $0x604
 4ac:	6a 01                	push   $0x1
 4ae:	e8 4d fb ff ff       	call   0 <printf>
 4b3:	83 c4 10             	add    $0x10,%esp
       exit();
 4b6:	e8 49 00 00 00       	call   504 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 4bb:	83 ec 04             	sub    $0x4,%esp
 4be:	68 e8 03 00 00       	push   $0x3e8
 4c3:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 4c9:	50                   	push   %eax
 4ca:	ff 75 f0             	pushl  -0x10(%ebp)
 4cd:	e8 52 00 00 00       	call   524 <write>
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 4da:	74 1a                	je     4f6 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 4dc:	83 ec 04             	sub    $0x4,%esp
 4df:	ff 75 f4             	pushl  -0xc(%ebp)
 4e2:	68 20 06 00 00       	push   $0x620
 4e7:	6a 01                	push   $0x1
 4e9:	e8 12 fb ff ff       	call   0 <printf>
 4ee:	83 c4 10             	add    $0x10,%esp
       exit();
 4f1:	e8 0e 00 00 00       	call   504 <exit>
     }
    
}
 4f6:	90                   	nop
 4f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4fa:	c9                   	leave  
 4fb:	c3                   	ret    

000004fc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4fc:	b8 01 00 00 00       	mov    $0x1,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <exit>:
SYSCALL(exit)
 504:	b8 02 00 00 00       	mov    $0x2,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <wait>:
SYSCALL(wait)
 50c:	b8 03 00 00 00       	mov    $0x3,%eax
 511:	cd 40                	int    $0x40
 513:	c3                   	ret    

00000514 <pipe>:
SYSCALL(pipe)
 514:	b8 04 00 00 00       	mov    $0x4,%eax
 519:	cd 40                	int    $0x40
 51b:	c3                   	ret    

0000051c <read>:
SYSCALL(read)
 51c:	b8 05 00 00 00       	mov    $0x5,%eax
 521:	cd 40                	int    $0x40
 523:	c3                   	ret    

00000524 <write>:
SYSCALL(write)
 524:	b8 10 00 00 00       	mov    $0x10,%eax
 529:	cd 40                	int    $0x40
 52b:	c3                   	ret    

0000052c <close>:
SYSCALL(close)
 52c:	b8 15 00 00 00       	mov    $0x15,%eax
 531:	cd 40                	int    $0x40
 533:	c3                   	ret    

00000534 <kill>:
SYSCALL(kill)
 534:	b8 06 00 00 00       	mov    $0x6,%eax
 539:	cd 40                	int    $0x40
 53b:	c3                   	ret    

0000053c <exec>:
SYSCALL(exec)
 53c:	b8 07 00 00 00       	mov    $0x7,%eax
 541:	cd 40                	int    $0x40
 543:	c3                   	ret    

00000544 <open>:
SYSCALL(open)
 544:	b8 0f 00 00 00       	mov    $0xf,%eax
 549:	cd 40                	int    $0x40
 54b:	c3                   	ret    

0000054c <mknod>:
SYSCALL(mknod)
 54c:	b8 11 00 00 00       	mov    $0x11,%eax
 551:	cd 40                	int    $0x40
 553:	c3                   	ret    

00000554 <unlink>:
SYSCALL(unlink)
 554:	b8 12 00 00 00       	mov    $0x12,%eax
 559:	cd 40                	int    $0x40
 55b:	c3                   	ret    

0000055c <fstat>:
SYSCALL(fstat)
 55c:	b8 08 00 00 00       	mov    $0x8,%eax
 561:	cd 40                	int    $0x40
 563:	c3                   	ret    

00000564 <link>:
SYSCALL(link)
 564:	b8 13 00 00 00       	mov    $0x13,%eax
 569:	cd 40                	int    $0x40
 56b:	c3                   	ret    

0000056c <mkdir>:
SYSCALL(mkdir)
 56c:	b8 14 00 00 00       	mov    $0x14,%eax
 571:	cd 40                	int    $0x40
 573:	c3                   	ret    

00000574 <chdir>:
SYSCALL(chdir)
 574:	b8 09 00 00 00       	mov    $0x9,%eax
 579:	cd 40                	int    $0x40
 57b:	c3                   	ret    

0000057c <dup>:
SYSCALL(dup)
 57c:	b8 0a 00 00 00       	mov    $0xa,%eax
 581:	cd 40                	int    $0x40
 583:	c3                   	ret    

00000584 <getpid>:
SYSCALL(getpid)
 584:	b8 0b 00 00 00       	mov    $0xb,%eax
 589:	cd 40                	int    $0x40
 58b:	c3                   	ret    

0000058c <sbrk>:
SYSCALL(sbrk)
 58c:	b8 0c 00 00 00       	mov    $0xc,%eax
 591:	cd 40                	int    $0x40
 593:	c3                   	ret    

00000594 <sleep>:
SYSCALL(sleep)
 594:	b8 0d 00 00 00       	mov    $0xd,%eax
 599:	cd 40                	int    $0x40
 59b:	c3                   	ret    

0000059c <uptime>:
SYSCALL(uptime)
 59c:	b8 0e 00 00 00       	mov    $0xe,%eax
 5a1:	cd 40                	int    $0x40
 5a3:	c3                   	ret    
