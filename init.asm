
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 23 0a 00 00       	push   $0xa23
  1b:	e8 12 05 00 00       	call   532 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 23 0a 00 00       	push   $0xa23
  33:	e8 02 05 00 00       	call   53a <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 23 0a 00 00       	push   $0xa23
  45:	e8 e8 04 00 00       	call   532 <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 13 05 00 00       	call   56a <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 06 05 00 00       	call   56a <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 2b 0a 00 00       	push   $0xa2b
  6f:	6a 01                	push   $0x1
  71:	e8 f3 05 00 00       	call   669 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  79:	e8 6c 04 00 00       	call   4ea <fork>
  7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
  87:	83 ec 08             	sub    $0x8,%esp
  8a:	68 3e 0a 00 00       	push   $0xa3e
  8f:	6a 01                	push   $0x1
  91:	e8 d3 05 00 00       	call   669 <printf>
  96:	83 c4 10             	add    $0x10,%esp
      exit();
  99:	e8 54 04 00 00       	call   4f2 <exit>
    }
    if(pid == 0){
  9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a2:	75 3e                	jne    e2 <main+0xe2>
      exec("sh", argv);
  a4:	83 ec 08             	sub    $0x8,%esp
  a7:	68 24 0d 00 00       	push   $0xd24
  ac:	68 20 0a 00 00       	push   $0xa20
  b1:	e8 74 04 00 00       	call   52a <exec>
  b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	68 51 0a 00 00       	push   $0xa51
  c1:	6a 01                	push   $0x1
  c3:	e8 a1 05 00 00       	call   669 <printf>
  c8:	83 c4 10             	add    $0x10,%esp
      exit();
  cb:	e8 22 04 00 00       	call   4f2 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  d0:	83 ec 08             	sub    $0x8,%esp
  d3:	68 67 0a 00 00       	push   $0xa67
  d8:	6a 01                	push   $0x1
  da:	e8 8a 05 00 00       	call   669 <printf>
  df:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  e2:	e8 13 04 00 00       	call   4fa <wait>
  e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
  f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  fa:	75 d4                	jne    d0 <main+0xd0>
      printf(1, "zombie!\n");
  }
  fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	57                   	push   %edi
 105:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 55 10             	mov    0x10(%ebp),%edx
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	89 cb                	mov    %ecx,%ebx
 111:	89 df                	mov    %ebx,%edi
 113:	89 d1                	mov    %edx,%ecx
 115:	fc                   	cld    
 116:	f3 aa                	rep stos %al,%es:(%edi)
 118:	89 ca                	mov    %ecx,%edx
 11a:	89 fb                	mov    %edi,%ebx
 11c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 122:	90                   	nop
 123:	5b                   	pop    %ebx
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    

00000127 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 133:	90                   	nop
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8d 50 01             	lea    0x1(%eax),%edx
 13a:	89 55 08             	mov    %edx,0x8(%ebp)
 13d:	8b 55 0c             	mov    0xc(%ebp),%edx
 140:	8d 4a 01             	lea    0x1(%edx),%ecx
 143:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 146:	0f b6 12             	movzbl (%edx),%edx
 149:	88 10                	mov    %dl,(%eax)
 14b:	0f b6 00             	movzbl (%eax),%eax
 14e:	84 c0                	test   %al,%al
 150:	75 e2                	jne    134 <strcpy+0xd>
    ;
  return os;
 152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 155:	c9                   	leave  
 156:	c3                   	ret    

00000157 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 157:	55                   	push   %ebp
 158:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 15a:	eb 08                	jmp    164 <strcmp+0xd>
    p++, q++;
 15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	0f b6 00             	movzbl (%eax),%eax
 16a:	84 c0                	test   %al,%al
 16c:	74 10                	je     17e <strcmp+0x27>
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	0f b6 10             	movzbl (%eax),%edx
 174:	8b 45 0c             	mov    0xc(%ebp),%eax
 177:	0f b6 00             	movzbl (%eax),%eax
 17a:	38 c2                	cmp    %al,%dl
 17c:	74 de                	je     15c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	0f b6 d0             	movzbl %al,%edx
 187:	8b 45 0c             	mov    0xc(%ebp),%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	0f b6 c0             	movzbl %al,%eax
 190:	29 c2                	sub    %eax,%edx
 192:	89 d0                	mov    %edx,%eax
}
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    

00000196 <strlen>:

uint
strlen(char *s)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 19c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a3:	eb 04                	jmp    1a9 <strlen+0x13>
 1a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
 1af:	01 d0                	add    %edx,%eax
 1b1:	0f b6 00             	movzbl (%eax),%eax
 1b4:	84 c0                	test   %al,%al
 1b6:	75 ed                	jne    1a5 <strlen+0xf>
    ;
  return n;
 1b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1bb:	c9                   	leave  
 1bc:	c3                   	ret    

000001bd <memset>:

void*
memset(void *dst, int c, uint n)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1c0:	8b 45 10             	mov    0x10(%ebp),%eax
 1c3:	50                   	push   %eax
 1c4:	ff 75 0c             	pushl  0xc(%ebp)
 1c7:	ff 75 08             	pushl  0x8(%ebp)
 1ca:	e8 32 ff ff ff       	call   101 <stosb>
 1cf:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d5:	c9                   	leave  
 1d6:	c3                   	ret    

000001d7 <strchr>:

char*
strchr(const char *s, char c)
{
 1d7:	55                   	push   %ebp
 1d8:	89 e5                	mov    %esp,%ebp
 1da:	83 ec 04             	sub    $0x4,%esp
 1dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1e3:	eb 14                	jmp    1f9 <strchr+0x22>
    if(*s == c)
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	0f b6 00             	movzbl (%eax),%eax
 1eb:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ee:	75 05                	jne    1f5 <strchr+0x1e>
      return (char*)s;
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	eb 13                	jmp    208 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	0f b6 00             	movzbl (%eax),%eax
 1ff:	84 c0                	test   %al,%al
 201:	75 e2                	jne    1e5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 203:	b8 00 00 00 00       	mov    $0x0,%eax
}
 208:	c9                   	leave  
 209:	c3                   	ret    

0000020a <gets>:

char*
gets(char *buf, int max)
{
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
 20d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 217:	eb 42                	jmp    25b <gets+0x51>
    cc = read(0, &c, 1);
 219:	83 ec 04             	sub    $0x4,%esp
 21c:	6a 01                	push   $0x1
 21e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 221:	50                   	push   %eax
 222:	6a 00                	push   $0x0
 224:	e8 e1 02 00 00       	call   50a <read>
 229:	83 c4 10             	add    $0x10,%esp
 22c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 22f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 233:	7e 33                	jle    268 <gets+0x5e>
      break;
    buf[i++] = c;
 235:	8b 45 f4             	mov    -0xc(%ebp),%eax
 238:	8d 50 01             	lea    0x1(%eax),%edx
 23b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 23e:	89 c2                	mov    %eax,%edx
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	01 c2                	add    %eax,%edx
 245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 249:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 24b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 24f:	3c 0a                	cmp    $0xa,%al
 251:	74 16                	je     269 <gets+0x5f>
 253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 257:	3c 0d                	cmp    $0xd,%al
 259:	74 0e                	je     269 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25e:	83 c0 01             	add    $0x1,%eax
 261:	3b 45 0c             	cmp    0xc(%ebp),%eax
 264:	7c b3                	jl     219 <gets+0xf>
 266:	eb 01                	jmp    269 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 268:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 269:	8b 55 f4             	mov    -0xc(%ebp),%edx
 26c:	8b 45 08             	mov    0x8(%ebp),%eax
 26f:	01 d0                	add    %edx,%eax
 271:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 274:	8b 45 08             	mov    0x8(%ebp),%eax
}
 277:	c9                   	leave  
 278:	c3                   	ret    

00000279 <stat>:

int
stat(char *n, struct stat *st)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
 27c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27f:	83 ec 08             	sub    $0x8,%esp
 282:	6a 00                	push   $0x0
 284:	ff 75 08             	pushl  0x8(%ebp)
 287:	e8 a6 02 00 00       	call   532 <open>
 28c:	83 c4 10             	add    $0x10,%esp
 28f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 292:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 296:	79 07                	jns    29f <stat+0x26>
    return -1;
 298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 29d:	eb 25                	jmp    2c4 <stat+0x4b>
  r = fstat(fd, st);
 29f:	83 ec 08             	sub    $0x8,%esp
 2a2:	ff 75 0c             	pushl  0xc(%ebp)
 2a5:	ff 75 f4             	pushl  -0xc(%ebp)
 2a8:	e8 9d 02 00 00       	call   54a <fstat>
 2ad:	83 c4 10             	add    $0x10,%esp
 2b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2b3:	83 ec 0c             	sub    $0xc,%esp
 2b6:	ff 75 f4             	pushl  -0xc(%ebp)
 2b9:	e8 5c 02 00 00       	call   51a <close>
 2be:	83 c4 10             	add    $0x10,%esp
  return r;
 2c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <atoi>:

int
atoi(const char *s)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2d3:	eb 25                	jmp    2fa <atoi+0x34>
    n = n*10 + *s++ - '0';
 2d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2d8:	89 d0                	mov    %edx,%eax
 2da:	c1 e0 02             	shl    $0x2,%eax
 2dd:	01 d0                	add    %edx,%eax
 2df:	01 c0                	add    %eax,%eax
 2e1:	89 c1                	mov    %eax,%ecx
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	8d 50 01             	lea    0x1(%eax),%edx
 2e9:	89 55 08             	mov    %edx,0x8(%ebp)
 2ec:	0f b6 00             	movzbl (%eax),%eax
 2ef:	0f be c0             	movsbl %al,%eax
 2f2:	01 c8                	add    %ecx,%eax
 2f4:	83 e8 30             	sub    $0x30,%eax
 2f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fa:	8b 45 08             	mov    0x8(%ebp),%eax
 2fd:	0f b6 00             	movzbl (%eax),%eax
 300:	3c 2f                	cmp    $0x2f,%al
 302:	7e 0a                	jle    30e <atoi+0x48>
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	0f b6 00             	movzbl (%eax),%eax
 30a:	3c 39                	cmp    $0x39,%al
 30c:	7e c7                	jle    2d5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 30e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 311:	c9                   	leave  
 312:	c3                   	ret    

00000313 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 313:	55                   	push   %ebp
 314:	89 e5                	mov    %esp,%ebp
 316:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 31f:	8b 45 0c             	mov    0xc(%ebp),%eax
 322:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 325:	eb 17                	jmp    33e <memmove+0x2b>
    *dst++ = *src++;
 327:	8b 45 fc             	mov    -0x4(%ebp),%eax
 32a:	8d 50 01             	lea    0x1(%eax),%edx
 32d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 330:	8b 55 f8             	mov    -0x8(%ebp),%edx
 333:	8d 4a 01             	lea    0x1(%edx),%ecx
 336:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 339:	0f b6 12             	movzbl (%edx),%edx
 33c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	8b 45 10             	mov    0x10(%ebp),%eax
 341:	8d 50 ff             	lea    -0x1(%eax),%edx
 344:	89 55 10             	mov    %edx,0x10(%ebp)
 347:	85 c0                	test   %eax,%eax
 349:	7f dc                	jg     327 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 34e:	c9                   	leave  
 34f:	c3                   	ret    

00000350 <historyAdd>:

void
historyAdd(char *buf1){
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 35a:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 361:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 368:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 36e:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 372:	83 ec 08             	sub    $0x8,%esp
 375:	6a 00                	push   $0x0
 377:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 37a:	50                   	push   %eax
 37b:	e8 b2 01 00 00       	call   532 <open>
 380:	83 c4 10             	add    $0x10,%esp
 383:	89 45 f0             	mov    %eax,-0x10(%ebp)
 386:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 38a:	79 1b                	jns    3a7 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 38c:	83 ec 04             	sub    $0x4,%esp
 38f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 392:	50                   	push   %eax
 393:	68 70 0a 00 00       	push   $0xa70
 398:	6a 01                	push   $0x1
 39a:	e8 ca 02 00 00       	call   669 <printf>
 39f:	83 c4 10             	add    $0x10,%esp
       exit();
 3a2:	e8 4b 01 00 00       	call   4f2 <exit>
     }

     int i=0;
 3a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 3ae:	eb 1c                	jmp    3cc <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 3b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	01 d0                	add    %edx,%eax
 3b8:	0f b6 00             	movzbl (%eax),%eax
 3bb:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 3c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3c4:	01 ca                	add    %ecx,%edx
 3c6:	88 02                	mov    %al,(%edx)
	i++;
 3c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 3cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3cf:	8b 45 08             	mov    0x8(%ebp),%eax
 3d2:	01 d0                	add    %edx,%eax
 3d4:	0f b6 00             	movzbl (%eax),%eax
 3d7:	84 c0                	test   %al,%al
 3d9:	75 d5                	jne    3b0 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 3db:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 3e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e4:	01 d0                	add    %edx,%eax
 3e6:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3e9:	eb 5a                	jmp    445 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 3eb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 3ee:	83 ec 0c             	sub    $0xc,%esp
 3f1:	ff 75 08             	pushl  0x8(%ebp)
 3f4:	e8 9d fd ff ff       	call   196 <strlen>
 3f9:	83 c4 10             	add    $0x10,%esp
 3fc:	29 c3                	sub    %eax,%ebx
 3fe:	89 d8                	mov    %ebx,%eax
 400:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 407:	ff 
 408:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 40e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 411:	01 ca                	add    %ecx,%edx
 413:	88 02                	mov    %al,(%edx)
		i++;
 415:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 419:	83 ec 0c             	sub    $0xc,%esp
 41c:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 422:	50                   	push   %eax
 423:	e8 6e fd ff ff       	call   196 <strlen>
 428:	83 c4 10             	add    $0x10,%esp
 42b:	89 c3                	mov    %eax,%ebx
 42d:	83 ec 0c             	sub    $0xc,%esp
 430:	ff 75 08             	pushl  0x8(%ebp)
 433:	e8 5e fd ff ff       	call   196 <strlen>
 438:	83 c4 10             	add    $0x10,%esp
 43b:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 43e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 441:	39 c2                	cmp    %eax,%edx
 443:	77 a6                	ja     3eb <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 445:	83 ec 04             	sub    $0x4,%esp
 448:	68 e8 03 00 00       	push   $0x3e8
 44d:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 453:	50                   	push   %eax
 454:	ff 75 f0             	pushl  -0x10(%ebp)
 457:	e8 ae 00 00 00       	call   50a <read>
 45c:	83 c4 10             	add    $0x10,%esp
 45f:	85 c0                	test   %eax,%eax
 461:	7f b6                	jg     419 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 463:	83 ec 0c             	sub    $0xc,%esp
 466:	ff 75 f0             	pushl  -0x10(%ebp)
 469:	e8 ac 00 00 00       	call   51a <close>
 46e:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 471:	83 ec 08             	sub    $0x8,%esp
 474:	68 02 02 00 00       	push   $0x202
 479:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 47c:	50                   	push   %eax
 47d:	e8 b0 00 00 00       	call   532 <open>
 482:	83 c4 10             	add    $0x10,%esp
 485:	89 45 f0             	mov    %eax,-0x10(%ebp)
 488:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 48c:	79 1b                	jns    4a9 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 48e:	83 ec 04             	sub    $0x4,%esp
 491:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 494:	50                   	push   %eax
 495:	68 70 0a 00 00       	push   $0xa70
 49a:	6a 01                	push   $0x1
 49c:	e8 c8 01 00 00       	call   669 <printf>
 4a1:	83 c4 10             	add    $0x10,%esp
       exit();
 4a4:	e8 49 00 00 00       	call   4f2 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 4a9:	83 ec 04             	sub    $0x4,%esp
 4ac:	68 e8 03 00 00       	push   $0x3e8
 4b1:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 4b7:	50                   	push   %eax
 4b8:	ff 75 f0             	pushl  -0x10(%ebp)
 4bb:	e8 52 00 00 00       	call   512 <write>
 4c0:	83 c4 10             	add    $0x10,%esp
 4c3:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 4c8:	74 1a                	je     4e4 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 4ca:	83 ec 04             	sub    $0x4,%esp
 4cd:	ff 75 f4             	pushl  -0xc(%ebp)
 4d0:	68 8c 0a 00 00       	push   $0xa8c
 4d5:	6a 01                	push   $0x1
 4d7:	e8 8d 01 00 00       	call   669 <printf>
 4dc:	83 c4 10             	add    $0x10,%esp
       exit();
 4df:	e8 0e 00 00 00       	call   4f2 <exit>
     }
    
}
 4e4:	90                   	nop
 4e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4e8:	c9                   	leave  
 4e9:	c3                   	ret    

000004ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ea:	b8 01 00 00 00       	mov    $0x1,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <exit>:
SYSCALL(exit)
 4f2:	b8 02 00 00 00       	mov    $0x2,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <wait>:
SYSCALL(wait)
 4fa:	b8 03 00 00 00       	mov    $0x3,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <pipe>:
SYSCALL(pipe)
 502:	b8 04 00 00 00       	mov    $0x4,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <read>:
SYSCALL(read)
 50a:	b8 05 00 00 00       	mov    $0x5,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <write>:
SYSCALL(write)
 512:	b8 10 00 00 00       	mov    $0x10,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <close>:
SYSCALL(close)
 51a:	b8 15 00 00 00       	mov    $0x15,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <kill>:
SYSCALL(kill)
 522:	b8 06 00 00 00       	mov    $0x6,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <exec>:
SYSCALL(exec)
 52a:	b8 07 00 00 00       	mov    $0x7,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <open>:
SYSCALL(open)
 532:	b8 0f 00 00 00       	mov    $0xf,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <mknod>:
SYSCALL(mknod)
 53a:	b8 11 00 00 00       	mov    $0x11,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <unlink>:
SYSCALL(unlink)
 542:	b8 12 00 00 00       	mov    $0x12,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <fstat>:
SYSCALL(fstat)
 54a:	b8 08 00 00 00       	mov    $0x8,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <link>:
SYSCALL(link)
 552:	b8 13 00 00 00       	mov    $0x13,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <mkdir>:
SYSCALL(mkdir)
 55a:	b8 14 00 00 00       	mov    $0x14,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <chdir>:
SYSCALL(chdir)
 562:	b8 09 00 00 00       	mov    $0x9,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <dup>:
SYSCALL(dup)
 56a:	b8 0a 00 00 00       	mov    $0xa,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <getpid>:
SYSCALL(getpid)
 572:	b8 0b 00 00 00       	mov    $0xb,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <sbrk>:
SYSCALL(sbrk)
 57a:	b8 0c 00 00 00       	mov    $0xc,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <sleep>:
SYSCALL(sleep)
 582:	b8 0d 00 00 00       	mov    $0xd,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <uptime>:
SYSCALL(uptime)
 58a:	b8 0e 00 00 00       	mov    $0xe,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 592:	55                   	push   %ebp
 593:	89 e5                	mov    %esp,%ebp
 595:	83 ec 18             	sub    $0x18,%esp
 598:	8b 45 0c             	mov    0xc(%ebp),%eax
 59b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 59e:	83 ec 04             	sub    $0x4,%esp
 5a1:	6a 01                	push   $0x1
 5a3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5a6:	50                   	push   %eax
 5a7:	ff 75 08             	pushl  0x8(%ebp)
 5aa:	e8 63 ff ff ff       	call   512 <write>
 5af:	83 c4 10             	add    $0x10,%esp
}
 5b2:	90                   	nop
 5b3:	c9                   	leave  
 5b4:	c3                   	ret    

000005b5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5b5:	55                   	push   %ebp
 5b6:	89 e5                	mov    %esp,%ebp
 5b8:	53                   	push   %ebx
 5b9:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5c3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5c7:	74 17                	je     5e0 <printint+0x2b>
 5c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5cd:	79 11                	jns    5e0 <printint+0x2b>
    neg = 1;
 5cf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5d9:	f7 d8                	neg    %eax
 5db:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5de:	eb 06                	jmp    5e6 <printint+0x31>
  } else {
    x = xx;
 5e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 5e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 5f0:	8d 41 01             	lea    0x1(%ecx),%eax
 5f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5fc:	ba 00 00 00 00       	mov    $0x0,%edx
 601:	f7 f3                	div    %ebx
 603:	89 d0                	mov    %edx,%eax
 605:	0f b6 80 2c 0d 00 00 	movzbl 0xd2c(%eax),%eax
 60c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 610:	8b 5d 10             	mov    0x10(%ebp),%ebx
 613:	8b 45 ec             	mov    -0x14(%ebp),%eax
 616:	ba 00 00 00 00       	mov    $0x0,%edx
 61b:	f7 f3                	div    %ebx
 61d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 620:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 624:	75 c7                	jne    5ed <printint+0x38>
  if(neg)
 626:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 62a:	74 2d                	je     659 <printint+0xa4>
    buf[i++] = '-';
 62c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62f:	8d 50 01             	lea    0x1(%eax),%edx
 632:	89 55 f4             	mov    %edx,-0xc(%ebp)
 635:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 63a:	eb 1d                	jmp    659 <printint+0xa4>
    putc(fd, buf[i]);
 63c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 63f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 642:	01 d0                	add    %edx,%eax
 644:	0f b6 00             	movzbl (%eax),%eax
 647:	0f be c0             	movsbl %al,%eax
 64a:	83 ec 08             	sub    $0x8,%esp
 64d:	50                   	push   %eax
 64e:	ff 75 08             	pushl  0x8(%ebp)
 651:	e8 3c ff ff ff       	call   592 <putc>
 656:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 659:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 65d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 661:	79 d9                	jns    63c <printint+0x87>
    putc(fd, buf[i]);
}
 663:	90                   	nop
 664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 667:	c9                   	leave  
 668:	c3                   	ret    

00000669 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 669:	55                   	push   %ebp
 66a:	89 e5                	mov    %esp,%ebp
 66c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 66f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 676:	8d 45 0c             	lea    0xc(%ebp),%eax
 679:	83 c0 04             	add    $0x4,%eax
 67c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 67f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 686:	e9 59 01 00 00       	jmp    7e4 <printf+0x17b>
    c = fmt[i] & 0xff;
 68b:	8b 55 0c             	mov    0xc(%ebp),%edx
 68e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 691:	01 d0                	add    %edx,%eax
 693:	0f b6 00             	movzbl (%eax),%eax
 696:	0f be c0             	movsbl %al,%eax
 699:	25 ff 00 00 00       	and    $0xff,%eax
 69e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6a5:	75 2c                	jne    6d3 <printf+0x6a>
      if(c == '%'){
 6a7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6ab:	75 0c                	jne    6b9 <printf+0x50>
        state = '%';
 6ad:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6b4:	e9 27 01 00 00       	jmp    7e0 <printf+0x177>
      } else {
        putc(fd, c);
 6b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6bc:	0f be c0             	movsbl %al,%eax
 6bf:	83 ec 08             	sub    $0x8,%esp
 6c2:	50                   	push   %eax
 6c3:	ff 75 08             	pushl  0x8(%ebp)
 6c6:	e8 c7 fe ff ff       	call   592 <putc>
 6cb:	83 c4 10             	add    $0x10,%esp
 6ce:	e9 0d 01 00 00       	jmp    7e0 <printf+0x177>
      }
    } else if(state == '%'){
 6d3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6d7:	0f 85 03 01 00 00    	jne    7e0 <printf+0x177>
      if(c == 'd'){
 6dd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6e1:	75 1e                	jne    701 <printf+0x98>
        printint(fd, *ap, 10, 1);
 6e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e6:	8b 00                	mov    (%eax),%eax
 6e8:	6a 01                	push   $0x1
 6ea:	6a 0a                	push   $0xa
 6ec:	50                   	push   %eax
 6ed:	ff 75 08             	pushl  0x8(%ebp)
 6f0:	e8 c0 fe ff ff       	call   5b5 <printint>
 6f5:	83 c4 10             	add    $0x10,%esp
        ap++;
 6f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6fc:	e9 d8 00 00 00       	jmp    7d9 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 701:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 705:	74 06                	je     70d <printf+0xa4>
 707:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 70b:	75 1e                	jne    72b <printf+0xc2>
        printint(fd, *ap, 16, 0);
 70d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 710:	8b 00                	mov    (%eax),%eax
 712:	6a 00                	push   $0x0
 714:	6a 10                	push   $0x10
 716:	50                   	push   %eax
 717:	ff 75 08             	pushl  0x8(%ebp)
 71a:	e8 96 fe ff ff       	call   5b5 <printint>
 71f:	83 c4 10             	add    $0x10,%esp
        ap++;
 722:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 726:	e9 ae 00 00 00       	jmp    7d9 <printf+0x170>
      } else if(c == 's'){
 72b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 72f:	75 43                	jne    774 <printf+0x10b>
        s = (char*)*ap;
 731:	8b 45 e8             	mov    -0x18(%ebp),%eax
 734:	8b 00                	mov    (%eax),%eax
 736:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 739:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 73d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 741:	75 25                	jne    768 <printf+0xff>
          s = "(null)";
 743:	c7 45 f4 b0 0a 00 00 	movl   $0xab0,-0xc(%ebp)
        while(*s != 0){
 74a:	eb 1c                	jmp    768 <printf+0xff>
          putc(fd, *s);
 74c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74f:	0f b6 00             	movzbl (%eax),%eax
 752:	0f be c0             	movsbl %al,%eax
 755:	83 ec 08             	sub    $0x8,%esp
 758:	50                   	push   %eax
 759:	ff 75 08             	pushl  0x8(%ebp)
 75c:	e8 31 fe ff ff       	call   592 <putc>
 761:	83 c4 10             	add    $0x10,%esp
          s++;
 764:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	0f b6 00             	movzbl (%eax),%eax
 76e:	84 c0                	test   %al,%al
 770:	75 da                	jne    74c <printf+0xe3>
 772:	eb 65                	jmp    7d9 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 774:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 778:	75 1d                	jne    797 <printf+0x12e>
        putc(fd, *ap);
 77a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 77d:	8b 00                	mov    (%eax),%eax
 77f:	0f be c0             	movsbl %al,%eax
 782:	83 ec 08             	sub    $0x8,%esp
 785:	50                   	push   %eax
 786:	ff 75 08             	pushl  0x8(%ebp)
 789:	e8 04 fe ff ff       	call   592 <putc>
 78e:	83 c4 10             	add    $0x10,%esp
        ap++;
 791:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 795:	eb 42                	jmp    7d9 <printf+0x170>
      } else if(c == '%'){
 797:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 79b:	75 17                	jne    7b4 <printf+0x14b>
        putc(fd, c);
 79d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7a0:	0f be c0             	movsbl %al,%eax
 7a3:	83 ec 08             	sub    $0x8,%esp
 7a6:	50                   	push   %eax
 7a7:	ff 75 08             	pushl  0x8(%ebp)
 7aa:	e8 e3 fd ff ff       	call   592 <putc>
 7af:	83 c4 10             	add    $0x10,%esp
 7b2:	eb 25                	jmp    7d9 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7b4:	83 ec 08             	sub    $0x8,%esp
 7b7:	6a 25                	push   $0x25
 7b9:	ff 75 08             	pushl  0x8(%ebp)
 7bc:	e8 d1 fd ff ff       	call   592 <putc>
 7c1:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 7c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7c7:	0f be c0             	movsbl %al,%eax
 7ca:	83 ec 08             	sub    $0x8,%esp
 7cd:	50                   	push   %eax
 7ce:	ff 75 08             	pushl  0x8(%ebp)
 7d1:	e8 bc fd ff ff       	call   592 <putc>
 7d6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7e0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7e4:	8b 55 0c             	mov    0xc(%ebp),%edx
 7e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ea:	01 d0                	add    %edx,%eax
 7ec:	0f b6 00             	movzbl (%eax),%eax
 7ef:	84 c0                	test   %al,%al
 7f1:	0f 85 94 fe ff ff    	jne    68b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7f7:	90                   	nop
 7f8:	c9                   	leave  
 7f9:	c3                   	ret    

000007fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7fa:	55                   	push   %ebp
 7fb:	89 e5                	mov    %esp,%ebp
 7fd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 800:	8b 45 08             	mov    0x8(%ebp),%eax
 803:	83 e8 08             	sub    $0x8,%eax
 806:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 809:	a1 48 0d 00 00       	mov    0xd48,%eax
 80e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 811:	eb 24                	jmp    837 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 813:	8b 45 fc             	mov    -0x4(%ebp),%eax
 816:	8b 00                	mov    (%eax),%eax
 818:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 81b:	77 12                	ja     82f <free+0x35>
 81d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 820:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 823:	77 24                	ja     849 <free+0x4f>
 825:	8b 45 fc             	mov    -0x4(%ebp),%eax
 828:	8b 00                	mov    (%eax),%eax
 82a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 82d:	77 1a                	ja     849 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 832:	8b 00                	mov    (%eax),%eax
 834:	89 45 fc             	mov    %eax,-0x4(%ebp)
 837:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 83d:	76 d4                	jbe    813 <free+0x19>
 83f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 842:	8b 00                	mov    (%eax),%eax
 844:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 847:	76 ca                	jbe    813 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 849:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84c:	8b 40 04             	mov    0x4(%eax),%eax
 84f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 856:	8b 45 f8             	mov    -0x8(%ebp),%eax
 859:	01 c2                	add    %eax,%edx
 85b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85e:	8b 00                	mov    (%eax),%eax
 860:	39 c2                	cmp    %eax,%edx
 862:	75 24                	jne    888 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 864:	8b 45 f8             	mov    -0x8(%ebp),%eax
 867:	8b 50 04             	mov    0x4(%eax),%edx
 86a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86d:	8b 00                	mov    (%eax),%eax
 86f:	8b 40 04             	mov    0x4(%eax),%eax
 872:	01 c2                	add    %eax,%edx
 874:	8b 45 f8             	mov    -0x8(%ebp),%eax
 877:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 87a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87d:	8b 00                	mov    (%eax),%eax
 87f:	8b 10                	mov    (%eax),%edx
 881:	8b 45 f8             	mov    -0x8(%ebp),%eax
 884:	89 10                	mov    %edx,(%eax)
 886:	eb 0a                	jmp    892 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 888:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88b:	8b 10                	mov    (%eax),%edx
 88d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 890:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 40 04             	mov    0x4(%eax),%eax
 898:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 89f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a2:	01 d0                	add    %edx,%eax
 8a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8a7:	75 20                	jne    8c9 <free+0xcf>
    p->s.size += bp->s.size;
 8a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ac:	8b 50 04             	mov    0x4(%eax),%edx
 8af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b2:	8b 40 04             	mov    0x4(%eax),%eax
 8b5:	01 c2                	add    %eax,%edx
 8b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ba:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c0:	8b 10                	mov    (%eax),%edx
 8c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c5:	89 10                	mov    %edx,(%eax)
 8c7:	eb 08                	jmp    8d1 <free+0xd7>
  } else
    p->s.ptr = bp;
 8c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8cf:	89 10                	mov    %edx,(%eax)
  freep = p;
 8d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d4:	a3 48 0d 00 00       	mov    %eax,0xd48
}
 8d9:	90                   	nop
 8da:	c9                   	leave  
 8db:	c3                   	ret    

000008dc <morecore>:

static Header*
morecore(uint nu)
{
 8dc:	55                   	push   %ebp
 8dd:	89 e5                	mov    %esp,%ebp
 8df:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8e2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8e9:	77 07                	ja     8f2 <morecore+0x16>
    nu = 4096;
 8eb:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8f2:	8b 45 08             	mov    0x8(%ebp),%eax
 8f5:	c1 e0 03             	shl    $0x3,%eax
 8f8:	83 ec 0c             	sub    $0xc,%esp
 8fb:	50                   	push   %eax
 8fc:	e8 79 fc ff ff       	call   57a <sbrk>
 901:	83 c4 10             	add    $0x10,%esp
 904:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 907:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 90b:	75 07                	jne    914 <morecore+0x38>
    return 0;
 90d:	b8 00 00 00 00       	mov    $0x0,%eax
 912:	eb 26                	jmp    93a <morecore+0x5e>
  hp = (Header*)p;
 914:	8b 45 f4             	mov    -0xc(%ebp),%eax
 917:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 91a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91d:	8b 55 08             	mov    0x8(%ebp),%edx
 920:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 923:	8b 45 f0             	mov    -0x10(%ebp),%eax
 926:	83 c0 08             	add    $0x8,%eax
 929:	83 ec 0c             	sub    $0xc,%esp
 92c:	50                   	push   %eax
 92d:	e8 c8 fe ff ff       	call   7fa <free>
 932:	83 c4 10             	add    $0x10,%esp
  return freep;
 935:	a1 48 0d 00 00       	mov    0xd48,%eax
}
 93a:	c9                   	leave  
 93b:	c3                   	ret    

0000093c <malloc>:

void*
malloc(uint nbytes)
{
 93c:	55                   	push   %ebp
 93d:	89 e5                	mov    %esp,%ebp
 93f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 942:	8b 45 08             	mov    0x8(%ebp),%eax
 945:	83 c0 07             	add    $0x7,%eax
 948:	c1 e8 03             	shr    $0x3,%eax
 94b:	83 c0 01             	add    $0x1,%eax
 94e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 951:	a1 48 0d 00 00       	mov    0xd48,%eax
 956:	89 45 f0             	mov    %eax,-0x10(%ebp)
 959:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 95d:	75 23                	jne    982 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 95f:	c7 45 f0 40 0d 00 00 	movl   $0xd40,-0x10(%ebp)
 966:	8b 45 f0             	mov    -0x10(%ebp),%eax
 969:	a3 48 0d 00 00       	mov    %eax,0xd48
 96e:	a1 48 0d 00 00       	mov    0xd48,%eax
 973:	a3 40 0d 00 00       	mov    %eax,0xd40
    base.s.size = 0;
 978:	c7 05 44 0d 00 00 00 	movl   $0x0,0xd44
 97f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 982:	8b 45 f0             	mov    -0x10(%ebp),%eax
 985:	8b 00                	mov    (%eax),%eax
 987:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 98a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98d:	8b 40 04             	mov    0x4(%eax),%eax
 990:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 993:	72 4d                	jb     9e2 <malloc+0xa6>
      if(p->s.size == nunits)
 995:	8b 45 f4             	mov    -0xc(%ebp),%eax
 998:	8b 40 04             	mov    0x4(%eax),%eax
 99b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 99e:	75 0c                	jne    9ac <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a3:	8b 10                	mov    (%eax),%edx
 9a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a8:	89 10                	mov    %edx,(%eax)
 9aa:	eb 26                	jmp    9d2 <malloc+0x96>
      else {
        p->s.size -= nunits;
 9ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9af:	8b 40 04             	mov    0x4(%eax),%eax
 9b2:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9b5:	89 c2                	mov    %eax,%edx
 9b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ba:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c0:	8b 40 04             	mov    0x4(%eax),%eax
 9c3:	c1 e0 03             	shl    $0x3,%eax
 9c6:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9cf:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d5:	a3 48 0d 00 00       	mov    %eax,0xd48
      return (void*)(p + 1);
 9da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9dd:	83 c0 08             	add    $0x8,%eax
 9e0:	eb 3b                	jmp    a1d <malloc+0xe1>
    }
    if(p == freep)
 9e2:	a1 48 0d 00 00       	mov    0xd48,%eax
 9e7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9ea:	75 1e                	jne    a0a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 9ec:	83 ec 0c             	sub    $0xc,%esp
 9ef:	ff 75 ec             	pushl  -0x14(%ebp)
 9f2:	e8 e5 fe ff ff       	call   8dc <morecore>
 9f7:	83 c4 10             	add    $0x10,%esp
 9fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a01:	75 07                	jne    a0a <malloc+0xce>
        return 0;
 a03:	b8 00 00 00 00       	mov    $0x0,%eax
 a08:	eb 13                	jmp    a1d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a13:	8b 00                	mov    (%eax),%eax
 a15:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a18:	e9 6d ff ff ff       	jmp    98a <malloc+0x4e>
}
 a1d:	c9                   	leave  
 a1e:	c3                   	ret    
