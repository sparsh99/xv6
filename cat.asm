
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 15                	jmp    1d <cat+0x1d>
    write(1, buf, n);
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	pushl  -0xc(%ebp)
   e:	68 80 0d 00 00       	push   $0xd80
  13:	6a 01                	push   $0x1
  15:	e8 06 05 00 00       	call   520 <write>
  1a:	83 c4 10             	add    $0x10,%esp
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  1d:	83 ec 04             	sub    $0x4,%esp
  20:	68 00 02 00 00       	push   $0x200
  25:	68 80 0d 00 00       	push   $0xd80
  2a:	ff 75 08             	pushl  0x8(%ebp)
  2d:	e8 e6 04 00 00       	call   518 <read>
  32:	83 c4 10             	add    $0x10,%esp
  35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  3c:	7f ca                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  42:	79 17                	jns    5b <cat+0x5b>
    printf(1, "cat: read error\n");
  44:	83 ec 08             	sub    $0x8,%esp
  47:	68 30 0a 00 00       	push   $0xa30
  4c:	6a 01                	push   $0x1
  4e:	e8 24 06 00 00       	call   677 <printf>
  53:	83 c4 10             	add    $0x10,%esp
    exit();
  56:	e8 a5 04 00 00       	call   500 <exit>
  }
}
  5b:	90                   	nop
  5c:	c9                   	leave  
  5d:	c3                   	ret    

0000005e <main>:

int
main(int argc, char *argv[])
{
  5e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  62:	83 e4 f0             	and    $0xfffffff0,%esp
  65:	ff 71 fc             	pushl  -0x4(%ecx)
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	53                   	push   %ebx
  6c:	51                   	push   %ecx
  6d:	83 ec 10             	sub    $0x10,%esp
  70:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  72:	83 3b 01             	cmpl   $0x1,(%ebx)
  75:	7f 12                	jg     89 <main+0x2b>
    cat(0);
  77:	83 ec 0c             	sub    $0xc,%esp
  7a:	6a 00                	push   $0x0
  7c:	e8 7f ff ff ff       	call   0 <cat>
  81:	83 c4 10             	add    $0x10,%esp
    exit();
  84:	e8 77 04 00 00       	call   500 <exit>
  }

  for(i = 1; i < argc; i++){
  89:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  90:	eb 71                	jmp    103 <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
  92:	8b 45 f4             	mov    -0xc(%ebp),%eax
  95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  9c:	8b 43 04             	mov    0x4(%ebx),%eax
  9f:	01 d0                	add    %edx,%eax
  a1:	8b 00                	mov    (%eax),%eax
  a3:	83 ec 08             	sub    $0x8,%esp
  a6:	6a 00                	push   $0x0
  a8:	50                   	push   %eax
  a9:	e8 92 04 00 00       	call   540 <open>
  ae:	83 c4 10             	add    $0x10,%esp
  b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  b8:	79 29                	jns    e3 <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
  ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  c4:	8b 43 04             	mov    0x4(%ebx),%eax
  c7:	01 d0                	add    %edx,%eax
  c9:	8b 00                	mov    (%eax),%eax
  cb:	83 ec 04             	sub    $0x4,%esp
  ce:	50                   	push   %eax
  cf:	68 41 0a 00 00       	push   $0xa41
  d4:	6a 01                	push   $0x1
  d6:	e8 9c 05 00 00       	call   677 <printf>
  db:	83 c4 10             	add    $0x10,%esp
      exit();
  de:	e8 1d 04 00 00       	call   500 <exit>
    }
    cat(fd);
  e3:	83 ec 0c             	sub    $0xc,%esp
  e6:	ff 75 f0             	pushl  -0x10(%ebp)
  e9:	e8 12 ff ff ff       	call   0 <cat>
  ee:	83 c4 10             	add    $0x10,%esp
    close(fd);
  f1:	83 ec 0c             	sub    $0xc,%esp
  f4:	ff 75 f0             	pushl  -0x10(%ebp)
  f7:	e8 2c 04 00 00       	call   528 <close>
  fc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 103:	8b 45 f4             	mov    -0xc(%ebp),%eax
 106:	3b 03                	cmp    (%ebx),%eax
 108:	7c 88                	jl     92 <main+0x34>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 10a:	e8 f1 03 00 00       	call   500 <exit>

0000010f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 10f:	55                   	push   %ebp
 110:	89 e5                	mov    %esp,%ebp
 112:	57                   	push   %edi
 113:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 114:	8b 4d 08             	mov    0x8(%ebp),%ecx
 117:	8b 55 10             	mov    0x10(%ebp),%edx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 cb                	mov    %ecx,%ebx
 11f:	89 df                	mov    %ebx,%edi
 121:	89 d1                	mov    %edx,%ecx
 123:	fc                   	cld    
 124:	f3 aa                	rep stos %al,%es:(%edi)
 126:	89 ca                	mov    %ecx,%edx
 128:	89 fb                	mov    %edi,%ebx
 12a:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 130:	90                   	nop
 131:	5b                   	pop    %ebx
 132:	5f                   	pop    %edi
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 141:	90                   	nop
 142:	8b 45 08             	mov    0x8(%ebp),%eax
 145:	8d 50 01             	lea    0x1(%eax),%edx
 148:	89 55 08             	mov    %edx,0x8(%ebp)
 14b:	8b 55 0c             	mov    0xc(%ebp),%edx
 14e:	8d 4a 01             	lea    0x1(%edx),%ecx
 151:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 154:	0f b6 12             	movzbl (%edx),%edx
 157:	88 10                	mov    %dl,(%eax)
 159:	0f b6 00             	movzbl (%eax),%eax
 15c:	84 c0                	test   %al,%al
 15e:	75 e2                	jne    142 <strcpy+0xd>
    ;
  return os;
 160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 163:	c9                   	leave  
 164:	c3                   	ret    

00000165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 165:	55                   	push   %ebp
 166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 168:	eb 08                	jmp    172 <strcmp+0xd>
    p++, q++;
 16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	84 c0                	test   %al,%al
 17a:	74 10                	je     18c <strcmp+0x27>
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	0f b6 10             	movzbl (%eax),%edx
 182:	8b 45 0c             	mov    0xc(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	38 c2                	cmp    %al,%dl
 18a:	74 de                	je     16a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 00             	movzbl (%eax),%eax
 192:	0f b6 d0             	movzbl %al,%edx
 195:	8b 45 0c             	mov    0xc(%ebp),%eax
 198:	0f b6 00             	movzbl (%eax),%eax
 19b:	0f b6 c0             	movzbl %al,%eax
 19e:	29 c2                	sub    %eax,%edx
 1a0:	89 d0                	mov    %edx,%eax
}
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    

000001a4 <strlen>:

uint
strlen(char *s)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b1:	eb 04                	jmp    1b7 <strlen+0x13>
 1b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	01 d0                	add    %edx,%eax
 1bf:	0f b6 00             	movzbl (%eax),%eax
 1c2:	84 c0                	test   %al,%al
 1c4:	75 ed                	jne    1b3 <strlen+0xf>
    ;
  return n;
 1c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c9:	c9                   	leave  
 1ca:	c3                   	ret    

000001cb <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cb:	55                   	push   %ebp
 1cc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1ce:	8b 45 10             	mov    0x10(%ebp),%eax
 1d1:	50                   	push   %eax
 1d2:	ff 75 0c             	pushl  0xc(%ebp)
 1d5:	ff 75 08             	pushl  0x8(%ebp)
 1d8:	e8 32 ff ff ff       	call   10f <stosb>
 1dd:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e3:	c9                   	leave  
 1e4:	c3                   	ret    

000001e5 <strchr>:

char*
strchr(const char *s, char c)
{
 1e5:	55                   	push   %ebp
 1e6:	89 e5                	mov    %esp,%ebp
 1e8:	83 ec 04             	sub    $0x4,%esp
 1eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ee:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1f1:	eb 14                	jmp    207 <strchr+0x22>
    if(*s == c)
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 00             	movzbl (%eax),%eax
 1f9:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1fc:	75 05                	jne    203 <strchr+0x1e>
      return (char*)s;
 1fe:	8b 45 08             	mov    0x8(%ebp),%eax
 201:	eb 13                	jmp    216 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 203:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	0f b6 00             	movzbl (%eax),%eax
 20d:	84 c0                	test   %al,%al
 20f:	75 e2                	jne    1f3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 211:	b8 00 00 00 00       	mov    $0x0,%eax
}
 216:	c9                   	leave  
 217:	c3                   	ret    

00000218 <gets>:

char*
gets(char *buf, int max)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 225:	eb 42                	jmp    269 <gets+0x51>
    cc = read(0, &c, 1);
 227:	83 ec 04             	sub    $0x4,%esp
 22a:	6a 01                	push   $0x1
 22c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 22f:	50                   	push   %eax
 230:	6a 00                	push   $0x0
 232:	e8 e1 02 00 00       	call   518 <read>
 237:	83 c4 10             	add    $0x10,%esp
 23a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 23d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 241:	7e 33                	jle    276 <gets+0x5e>
      break;
    buf[i++] = c;
 243:	8b 45 f4             	mov    -0xc(%ebp),%eax
 246:	8d 50 01             	lea    0x1(%eax),%edx
 249:	89 55 f4             	mov    %edx,-0xc(%ebp)
 24c:	89 c2                	mov    %eax,%edx
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	01 c2                	add    %eax,%edx
 253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 257:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 259:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25d:	3c 0a                	cmp    $0xa,%al
 25f:	74 16                	je     277 <gets+0x5f>
 261:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 265:	3c 0d                	cmp    $0xd,%al
 267:	74 0e                	je     277 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 269:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26c:	83 c0 01             	add    $0x1,%eax
 26f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 272:	7c b3                	jl     227 <gets+0xf>
 274:	eb 01                	jmp    277 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 276:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 277:	8b 55 f4             	mov    -0xc(%ebp),%edx
 27a:	8b 45 08             	mov    0x8(%ebp),%eax
 27d:	01 d0                	add    %edx,%eax
 27f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 282:	8b 45 08             	mov    0x8(%ebp),%eax
}
 285:	c9                   	leave  
 286:	c3                   	ret    

00000287 <stat>:

int
stat(char *n, struct stat *st)
{
 287:	55                   	push   %ebp
 288:	89 e5                	mov    %esp,%ebp
 28a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28d:	83 ec 08             	sub    $0x8,%esp
 290:	6a 00                	push   $0x0
 292:	ff 75 08             	pushl  0x8(%ebp)
 295:	e8 a6 02 00 00       	call   540 <open>
 29a:	83 c4 10             	add    $0x10,%esp
 29d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a4:	79 07                	jns    2ad <stat+0x26>
    return -1;
 2a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ab:	eb 25                	jmp    2d2 <stat+0x4b>
  r = fstat(fd, st);
 2ad:	83 ec 08             	sub    $0x8,%esp
 2b0:	ff 75 0c             	pushl  0xc(%ebp)
 2b3:	ff 75 f4             	pushl  -0xc(%ebp)
 2b6:	e8 9d 02 00 00       	call   558 <fstat>
 2bb:	83 c4 10             	add    $0x10,%esp
 2be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c1:	83 ec 0c             	sub    $0xc,%esp
 2c4:	ff 75 f4             	pushl  -0xc(%ebp)
 2c7:	e8 5c 02 00 00       	call   528 <close>
 2cc:	83 c4 10             	add    $0x10,%esp
  return r;
 2cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2d2:	c9                   	leave  
 2d3:	c3                   	ret    

000002d4 <atoi>:

int
atoi(const char *s)
{
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e1:	eb 25                	jmp    308 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e6:	89 d0                	mov    %edx,%eax
 2e8:	c1 e0 02             	shl    $0x2,%eax
 2eb:	01 d0                	add    %edx,%eax
 2ed:	01 c0                	add    %eax,%eax
 2ef:	89 c1                	mov    %eax,%ecx
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
 2f4:	8d 50 01             	lea    0x1(%eax),%edx
 2f7:	89 55 08             	mov    %edx,0x8(%ebp)
 2fa:	0f b6 00             	movzbl (%eax),%eax
 2fd:	0f be c0             	movsbl %al,%eax
 300:	01 c8                	add    %ecx,%eax
 302:	83 e8 30             	sub    $0x30,%eax
 305:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	0f b6 00             	movzbl (%eax),%eax
 30e:	3c 2f                	cmp    $0x2f,%al
 310:	7e 0a                	jle    31c <atoi+0x48>
 312:	8b 45 08             	mov    0x8(%ebp),%eax
 315:	0f b6 00             	movzbl (%eax),%eax
 318:	3c 39                	cmp    $0x39,%al
 31a:	7e c7                	jle    2e3 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 31c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 31f:	c9                   	leave  
 320:	c3                   	ret    

00000321 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 321:	55                   	push   %ebp
 322:	89 e5                	mov    %esp,%ebp
 324:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 327:	8b 45 08             	mov    0x8(%ebp),%eax
 32a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 32d:	8b 45 0c             	mov    0xc(%ebp),%eax
 330:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 333:	eb 17                	jmp    34c <memmove+0x2b>
    *dst++ = *src++;
 335:	8b 45 fc             	mov    -0x4(%ebp),%eax
 338:	8d 50 01             	lea    0x1(%eax),%edx
 33b:	89 55 fc             	mov    %edx,-0x4(%ebp)
 33e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 341:	8d 4a 01             	lea    0x1(%edx),%ecx
 344:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 347:	0f b6 12             	movzbl (%edx),%edx
 34a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34c:	8b 45 10             	mov    0x10(%ebp),%eax
 34f:	8d 50 ff             	lea    -0x1(%eax),%edx
 352:	89 55 10             	mov    %edx,0x10(%ebp)
 355:	85 c0                	test   %eax,%eax
 357:	7f dc                	jg     335 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 359:	8b 45 08             	mov    0x8(%ebp),%eax
}
 35c:	c9                   	leave  
 35d:	c3                   	ret    

0000035e <historyAdd>:

void
historyAdd(char *buf1){
 35e:	55                   	push   %ebp
 35f:	89 e5                	mov    %esp,%ebp
 361:	53                   	push   %ebx
 362:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 368:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 36f:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 376:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 37c:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 380:	83 ec 08             	sub    $0x8,%esp
 383:	6a 00                	push   $0x0
 385:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 388:	50                   	push   %eax
 389:	e8 b2 01 00 00       	call   540 <open>
 38e:	83 c4 10             	add    $0x10,%esp
 391:	89 45 f0             	mov    %eax,-0x10(%ebp)
 394:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 398:	79 1b                	jns    3b5 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 39a:	83 ec 04             	sub    $0x4,%esp
 39d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3a0:	50                   	push   %eax
 3a1:	68 58 0a 00 00       	push   $0xa58
 3a6:	6a 01                	push   $0x1
 3a8:	e8 ca 02 00 00       	call   677 <printf>
 3ad:	83 c4 10             	add    $0x10,%esp
       exit();
 3b0:	e8 4b 01 00 00       	call   500 <exit>
     }

     int i=0;
 3b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 3bc:	eb 1c                	jmp    3da <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 3be:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3c1:	8b 45 08             	mov    0x8(%ebp),%eax
 3c4:	01 d0                	add    %edx,%eax
 3c6:	0f b6 00             	movzbl (%eax),%eax
 3c9:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 3cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3d2:	01 ca                	add    %ecx,%edx
 3d4:	88 02                	mov    %al,(%edx)
	i++;
 3d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 3da:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	01 d0                	add    %edx,%eax
 3e2:	0f b6 00             	movzbl (%eax),%eax
 3e5:	84 c0                	test   %al,%al
 3e7:	75 d5                	jne    3be <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 3e9:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 3ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f2:	01 d0                	add    %edx,%eax
 3f4:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3f7:	eb 5a                	jmp    453 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 3f9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 3fc:	83 ec 0c             	sub    $0xc,%esp
 3ff:	ff 75 08             	pushl  0x8(%ebp)
 402:	e8 9d fd ff ff       	call   1a4 <strlen>
 407:	83 c4 10             	add    $0x10,%esp
 40a:	29 c3                	sub    %eax,%ebx
 40c:	89 d8                	mov    %ebx,%eax
 40e:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 415:	ff 
 416:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 41c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 41f:	01 ca                	add    %ecx,%edx
 421:	88 02                	mov    %al,(%edx)
		i++;
 423:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 427:	83 ec 0c             	sub    $0xc,%esp
 42a:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 430:	50                   	push   %eax
 431:	e8 6e fd ff ff       	call   1a4 <strlen>
 436:	83 c4 10             	add    $0x10,%esp
 439:	89 c3                	mov    %eax,%ebx
 43b:	83 ec 0c             	sub    $0xc,%esp
 43e:	ff 75 08             	pushl  0x8(%ebp)
 441:	e8 5e fd ff ff       	call   1a4 <strlen>
 446:	83 c4 10             	add    $0x10,%esp
 449:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 44f:	39 c2                	cmp    %eax,%edx
 451:	77 a6                	ja     3f9 <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 453:	83 ec 04             	sub    $0x4,%esp
 456:	68 e8 03 00 00       	push   $0x3e8
 45b:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 461:	50                   	push   %eax
 462:	ff 75 f0             	pushl  -0x10(%ebp)
 465:	e8 ae 00 00 00       	call   518 <read>
 46a:	83 c4 10             	add    $0x10,%esp
 46d:	85 c0                	test   %eax,%eax
 46f:	7f b6                	jg     427 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 471:	83 ec 0c             	sub    $0xc,%esp
 474:	ff 75 f0             	pushl  -0x10(%ebp)
 477:	e8 ac 00 00 00       	call   528 <close>
 47c:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 47f:	83 ec 08             	sub    $0x8,%esp
 482:	68 02 02 00 00       	push   $0x202
 487:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 48a:	50                   	push   %eax
 48b:	e8 b0 00 00 00       	call   540 <open>
 490:	83 c4 10             	add    $0x10,%esp
 493:	89 45 f0             	mov    %eax,-0x10(%ebp)
 496:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49a:	79 1b                	jns    4b7 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 49c:	83 ec 04             	sub    $0x4,%esp
 49f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4a2:	50                   	push   %eax
 4a3:	68 58 0a 00 00       	push   $0xa58
 4a8:	6a 01                	push   $0x1
 4aa:	e8 c8 01 00 00       	call   677 <printf>
 4af:	83 c4 10             	add    $0x10,%esp
       exit();
 4b2:	e8 49 00 00 00       	call   500 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 4b7:	83 ec 04             	sub    $0x4,%esp
 4ba:	68 e8 03 00 00       	push   $0x3e8
 4bf:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 4c5:	50                   	push   %eax
 4c6:	ff 75 f0             	pushl  -0x10(%ebp)
 4c9:	e8 52 00 00 00       	call   520 <write>
 4ce:	83 c4 10             	add    $0x10,%esp
 4d1:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 4d6:	74 1a                	je     4f2 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 4d8:	83 ec 04             	sub    $0x4,%esp
 4db:	ff 75 f4             	pushl  -0xc(%ebp)
 4de:	68 74 0a 00 00       	push   $0xa74
 4e3:	6a 01                	push   $0x1
 4e5:	e8 8d 01 00 00       	call   677 <printf>
 4ea:	83 c4 10             	add    $0x10,%esp
       exit();
 4ed:	e8 0e 00 00 00       	call   500 <exit>
     }
    
}
 4f2:	90                   	nop
 4f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f6:	c9                   	leave  
 4f7:	c3                   	ret    

000004f8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4f8:	b8 01 00 00 00       	mov    $0x1,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <exit>:
SYSCALL(exit)
 500:	b8 02 00 00 00       	mov    $0x2,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <wait>:
SYSCALL(wait)
 508:	b8 03 00 00 00       	mov    $0x3,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <pipe>:
SYSCALL(pipe)
 510:	b8 04 00 00 00       	mov    $0x4,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <read>:
SYSCALL(read)
 518:	b8 05 00 00 00       	mov    $0x5,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <write>:
SYSCALL(write)
 520:	b8 10 00 00 00       	mov    $0x10,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <close>:
SYSCALL(close)
 528:	b8 15 00 00 00       	mov    $0x15,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <kill>:
SYSCALL(kill)
 530:	b8 06 00 00 00       	mov    $0x6,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret    

00000538 <exec>:
SYSCALL(exec)
 538:	b8 07 00 00 00       	mov    $0x7,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret    

00000540 <open>:
SYSCALL(open)
 540:	b8 0f 00 00 00       	mov    $0xf,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret    

00000548 <mknod>:
SYSCALL(mknod)
 548:	b8 11 00 00 00       	mov    $0x11,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <unlink>:
SYSCALL(unlink)
 550:	b8 12 00 00 00       	mov    $0x12,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <fstat>:
SYSCALL(fstat)
 558:	b8 08 00 00 00       	mov    $0x8,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <link>:
SYSCALL(link)
 560:	b8 13 00 00 00       	mov    $0x13,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <mkdir>:
SYSCALL(mkdir)
 568:	b8 14 00 00 00       	mov    $0x14,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <chdir>:
SYSCALL(chdir)
 570:	b8 09 00 00 00       	mov    $0x9,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <dup>:
SYSCALL(dup)
 578:	b8 0a 00 00 00       	mov    $0xa,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <getpid>:
SYSCALL(getpid)
 580:	b8 0b 00 00 00       	mov    $0xb,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <sbrk>:
SYSCALL(sbrk)
 588:	b8 0c 00 00 00       	mov    $0xc,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <sleep>:
SYSCALL(sleep)
 590:	b8 0d 00 00 00       	mov    $0xd,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <uptime>:
SYSCALL(uptime)
 598:	b8 0e 00 00 00       	mov    $0xe,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	83 ec 18             	sub    $0x18,%esp
 5a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5a9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5ac:	83 ec 04             	sub    $0x4,%esp
 5af:	6a 01                	push   $0x1
 5b1:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5b4:	50                   	push   %eax
 5b5:	ff 75 08             	pushl  0x8(%ebp)
 5b8:	e8 63 ff ff ff       	call   520 <write>
 5bd:	83 c4 10             	add    $0x10,%esp
}
 5c0:	90                   	nop
 5c1:	c9                   	leave  
 5c2:	c3                   	ret    

000005c3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5c3:	55                   	push   %ebp
 5c4:	89 e5                	mov    %esp,%ebp
 5c6:	53                   	push   %ebx
 5c7:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5d1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5d5:	74 17                	je     5ee <printint+0x2b>
 5d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5db:	79 11                	jns    5ee <printint+0x2b>
    neg = 1;
 5dd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 5e7:	f7 d8                	neg    %eax
 5e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5ec:	eb 06                	jmp    5f4 <printint+0x31>
  } else {
    x = xx;
 5ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5fb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 5fe:	8d 41 01             	lea    0x1(%ecx),%eax
 601:	89 45 f4             	mov    %eax,-0xc(%ebp)
 604:	8b 5d 10             	mov    0x10(%ebp),%ebx
 607:	8b 45 ec             	mov    -0x14(%ebp),%eax
 60a:	ba 00 00 00 00       	mov    $0x0,%edx
 60f:	f7 f3                	div    %ebx
 611:	89 d0                	mov    %edx,%eax
 613:	0f b6 80 30 0d 00 00 	movzbl 0xd30(%eax),%eax
 61a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 61e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 621:	8b 45 ec             	mov    -0x14(%ebp),%eax
 624:	ba 00 00 00 00       	mov    $0x0,%edx
 629:	f7 f3                	div    %ebx
 62b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 62e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 632:	75 c7                	jne    5fb <printint+0x38>
  if(neg)
 634:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 638:	74 2d                	je     667 <printint+0xa4>
    buf[i++] = '-';
 63a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63d:	8d 50 01             	lea    0x1(%eax),%edx
 640:	89 55 f4             	mov    %edx,-0xc(%ebp)
 643:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 648:	eb 1d                	jmp    667 <printint+0xa4>
    putc(fd, buf[i]);
 64a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 64d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 650:	01 d0                	add    %edx,%eax
 652:	0f b6 00             	movzbl (%eax),%eax
 655:	0f be c0             	movsbl %al,%eax
 658:	83 ec 08             	sub    $0x8,%esp
 65b:	50                   	push   %eax
 65c:	ff 75 08             	pushl  0x8(%ebp)
 65f:	e8 3c ff ff ff       	call   5a0 <putc>
 664:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 667:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 66b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 66f:	79 d9                	jns    64a <printint+0x87>
    putc(fd, buf[i]);
}
 671:	90                   	nop
 672:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 675:	c9                   	leave  
 676:	c3                   	ret    

00000677 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 677:	55                   	push   %ebp
 678:	89 e5                	mov    %esp,%ebp
 67a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 67d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 684:	8d 45 0c             	lea    0xc(%ebp),%eax
 687:	83 c0 04             	add    $0x4,%eax
 68a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 68d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 694:	e9 59 01 00 00       	jmp    7f2 <printf+0x17b>
    c = fmt[i] & 0xff;
 699:	8b 55 0c             	mov    0xc(%ebp),%edx
 69c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 69f:	01 d0                	add    %edx,%eax
 6a1:	0f b6 00             	movzbl (%eax),%eax
 6a4:	0f be c0             	movsbl %al,%eax
 6a7:	25 ff 00 00 00       	and    $0xff,%eax
 6ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6b3:	75 2c                	jne    6e1 <printf+0x6a>
      if(c == '%'){
 6b5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6b9:	75 0c                	jne    6c7 <printf+0x50>
        state = '%';
 6bb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6c2:	e9 27 01 00 00       	jmp    7ee <printf+0x177>
      } else {
        putc(fd, c);
 6c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ca:	0f be c0             	movsbl %al,%eax
 6cd:	83 ec 08             	sub    $0x8,%esp
 6d0:	50                   	push   %eax
 6d1:	ff 75 08             	pushl  0x8(%ebp)
 6d4:	e8 c7 fe ff ff       	call   5a0 <putc>
 6d9:	83 c4 10             	add    $0x10,%esp
 6dc:	e9 0d 01 00 00       	jmp    7ee <printf+0x177>
      }
    } else if(state == '%'){
 6e1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6e5:	0f 85 03 01 00 00    	jne    7ee <printf+0x177>
      if(c == 'd'){
 6eb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6ef:	75 1e                	jne    70f <printf+0x98>
        printint(fd, *ap, 10, 1);
 6f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6f4:	8b 00                	mov    (%eax),%eax
 6f6:	6a 01                	push   $0x1
 6f8:	6a 0a                	push   $0xa
 6fa:	50                   	push   %eax
 6fb:	ff 75 08             	pushl  0x8(%ebp)
 6fe:	e8 c0 fe ff ff       	call   5c3 <printint>
 703:	83 c4 10             	add    $0x10,%esp
        ap++;
 706:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 70a:	e9 d8 00 00 00       	jmp    7e7 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 70f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 713:	74 06                	je     71b <printf+0xa4>
 715:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 719:	75 1e                	jne    739 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 71b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 71e:	8b 00                	mov    (%eax),%eax
 720:	6a 00                	push   $0x0
 722:	6a 10                	push   $0x10
 724:	50                   	push   %eax
 725:	ff 75 08             	pushl  0x8(%ebp)
 728:	e8 96 fe ff ff       	call   5c3 <printint>
 72d:	83 c4 10             	add    $0x10,%esp
        ap++;
 730:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 734:	e9 ae 00 00 00       	jmp    7e7 <printf+0x170>
      } else if(c == 's'){
 739:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 73d:	75 43                	jne    782 <printf+0x10b>
        s = (char*)*ap;
 73f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 742:	8b 00                	mov    (%eax),%eax
 744:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 747:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 74b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 74f:	75 25                	jne    776 <printf+0xff>
          s = "(null)";
 751:	c7 45 f4 98 0a 00 00 	movl   $0xa98,-0xc(%ebp)
        while(*s != 0){
 758:	eb 1c                	jmp    776 <printf+0xff>
          putc(fd, *s);
 75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75d:	0f b6 00             	movzbl (%eax),%eax
 760:	0f be c0             	movsbl %al,%eax
 763:	83 ec 08             	sub    $0x8,%esp
 766:	50                   	push   %eax
 767:	ff 75 08             	pushl  0x8(%ebp)
 76a:	e8 31 fe ff ff       	call   5a0 <putc>
 76f:	83 c4 10             	add    $0x10,%esp
          s++;
 772:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 776:	8b 45 f4             	mov    -0xc(%ebp),%eax
 779:	0f b6 00             	movzbl (%eax),%eax
 77c:	84 c0                	test   %al,%al
 77e:	75 da                	jne    75a <printf+0xe3>
 780:	eb 65                	jmp    7e7 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 782:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 786:	75 1d                	jne    7a5 <printf+0x12e>
        putc(fd, *ap);
 788:	8b 45 e8             	mov    -0x18(%ebp),%eax
 78b:	8b 00                	mov    (%eax),%eax
 78d:	0f be c0             	movsbl %al,%eax
 790:	83 ec 08             	sub    $0x8,%esp
 793:	50                   	push   %eax
 794:	ff 75 08             	pushl  0x8(%ebp)
 797:	e8 04 fe ff ff       	call   5a0 <putc>
 79c:	83 c4 10             	add    $0x10,%esp
        ap++;
 79f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7a3:	eb 42                	jmp    7e7 <printf+0x170>
      } else if(c == '%'){
 7a5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7a9:	75 17                	jne    7c2 <printf+0x14b>
        putc(fd, c);
 7ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7ae:	0f be c0             	movsbl %al,%eax
 7b1:	83 ec 08             	sub    $0x8,%esp
 7b4:	50                   	push   %eax
 7b5:	ff 75 08             	pushl  0x8(%ebp)
 7b8:	e8 e3 fd ff ff       	call   5a0 <putc>
 7bd:	83 c4 10             	add    $0x10,%esp
 7c0:	eb 25                	jmp    7e7 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7c2:	83 ec 08             	sub    $0x8,%esp
 7c5:	6a 25                	push   $0x25
 7c7:	ff 75 08             	pushl  0x8(%ebp)
 7ca:	e8 d1 fd ff ff       	call   5a0 <putc>
 7cf:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 7d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7d5:	0f be c0             	movsbl %al,%eax
 7d8:	83 ec 08             	sub    $0x8,%esp
 7db:	50                   	push   %eax
 7dc:	ff 75 08             	pushl  0x8(%ebp)
 7df:	e8 bc fd ff ff       	call   5a0 <putc>
 7e4:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7e7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7ee:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7f2:	8b 55 0c             	mov    0xc(%ebp),%edx
 7f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f8:	01 d0                	add    %edx,%eax
 7fa:	0f b6 00             	movzbl (%eax),%eax
 7fd:	84 c0                	test   %al,%al
 7ff:	0f 85 94 fe ff ff    	jne    699 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 805:	90                   	nop
 806:	c9                   	leave  
 807:	c3                   	ret    

00000808 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 808:	55                   	push   %ebp
 809:	89 e5                	mov    %esp,%ebp
 80b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 80e:	8b 45 08             	mov    0x8(%ebp),%eax
 811:	83 e8 08             	sub    $0x8,%eax
 814:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 817:	a1 68 0d 00 00       	mov    0xd68,%eax
 81c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 81f:	eb 24                	jmp    845 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 821:	8b 45 fc             	mov    -0x4(%ebp),%eax
 824:	8b 00                	mov    (%eax),%eax
 826:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 829:	77 12                	ja     83d <free+0x35>
 82b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 831:	77 24                	ja     857 <free+0x4f>
 833:	8b 45 fc             	mov    -0x4(%ebp),%eax
 836:	8b 00                	mov    (%eax),%eax
 838:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 83b:	77 1a                	ja     857 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 840:	8b 00                	mov    (%eax),%eax
 842:	89 45 fc             	mov    %eax,-0x4(%ebp)
 845:	8b 45 f8             	mov    -0x8(%ebp),%eax
 848:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 84b:	76 d4                	jbe    821 <free+0x19>
 84d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 850:	8b 00                	mov    (%eax),%eax
 852:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 855:	76 ca                	jbe    821 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 857:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85a:	8b 40 04             	mov    0x4(%eax),%eax
 85d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 864:	8b 45 f8             	mov    -0x8(%ebp),%eax
 867:	01 c2                	add    %eax,%edx
 869:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86c:	8b 00                	mov    (%eax),%eax
 86e:	39 c2                	cmp    %eax,%edx
 870:	75 24                	jne    896 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 872:	8b 45 f8             	mov    -0x8(%ebp),%eax
 875:	8b 50 04             	mov    0x4(%eax),%edx
 878:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87b:	8b 00                	mov    (%eax),%eax
 87d:	8b 40 04             	mov    0x4(%eax),%eax
 880:	01 c2                	add    %eax,%edx
 882:	8b 45 f8             	mov    -0x8(%ebp),%eax
 885:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 888:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88b:	8b 00                	mov    (%eax),%eax
 88d:	8b 10                	mov    (%eax),%edx
 88f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 892:	89 10                	mov    %edx,(%eax)
 894:	eb 0a                	jmp    8a0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 896:	8b 45 fc             	mov    -0x4(%ebp),%eax
 899:	8b 10                	mov    (%eax),%edx
 89b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a3:	8b 40 04             	mov    0x4(%eax),%eax
 8a6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b0:	01 d0                	add    %edx,%eax
 8b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8b5:	75 20                	jne    8d7 <free+0xcf>
    p->s.size += bp->s.size;
 8b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ba:	8b 50 04             	mov    0x4(%eax),%edx
 8bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c0:	8b 40 04             	mov    0x4(%eax),%eax
 8c3:	01 c2                	add    %eax,%edx
 8c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ce:	8b 10                	mov    (%eax),%edx
 8d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d3:	89 10                	mov    %edx,(%eax)
 8d5:	eb 08                	jmp    8df <free+0xd7>
  } else
    p->s.ptr = bp;
 8d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8da:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8dd:	89 10                	mov    %edx,(%eax)
  freep = p;
 8df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e2:	a3 68 0d 00 00       	mov    %eax,0xd68
}
 8e7:	90                   	nop
 8e8:	c9                   	leave  
 8e9:	c3                   	ret    

000008ea <morecore>:

static Header*
morecore(uint nu)
{
 8ea:	55                   	push   %ebp
 8eb:	89 e5                	mov    %esp,%ebp
 8ed:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8f0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8f7:	77 07                	ja     900 <morecore+0x16>
    nu = 4096;
 8f9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 900:	8b 45 08             	mov    0x8(%ebp),%eax
 903:	c1 e0 03             	shl    $0x3,%eax
 906:	83 ec 0c             	sub    $0xc,%esp
 909:	50                   	push   %eax
 90a:	e8 79 fc ff ff       	call   588 <sbrk>
 90f:	83 c4 10             	add    $0x10,%esp
 912:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 915:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 919:	75 07                	jne    922 <morecore+0x38>
    return 0;
 91b:	b8 00 00 00 00       	mov    $0x0,%eax
 920:	eb 26                	jmp    948 <morecore+0x5e>
  hp = (Header*)p;
 922:	8b 45 f4             	mov    -0xc(%ebp),%eax
 925:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 928:	8b 45 f0             	mov    -0x10(%ebp),%eax
 92b:	8b 55 08             	mov    0x8(%ebp),%edx
 92e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 931:	8b 45 f0             	mov    -0x10(%ebp),%eax
 934:	83 c0 08             	add    $0x8,%eax
 937:	83 ec 0c             	sub    $0xc,%esp
 93a:	50                   	push   %eax
 93b:	e8 c8 fe ff ff       	call   808 <free>
 940:	83 c4 10             	add    $0x10,%esp
  return freep;
 943:	a1 68 0d 00 00       	mov    0xd68,%eax
}
 948:	c9                   	leave  
 949:	c3                   	ret    

0000094a <malloc>:

void*
malloc(uint nbytes)
{
 94a:	55                   	push   %ebp
 94b:	89 e5                	mov    %esp,%ebp
 94d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 950:	8b 45 08             	mov    0x8(%ebp),%eax
 953:	83 c0 07             	add    $0x7,%eax
 956:	c1 e8 03             	shr    $0x3,%eax
 959:	83 c0 01             	add    $0x1,%eax
 95c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 95f:	a1 68 0d 00 00       	mov    0xd68,%eax
 964:	89 45 f0             	mov    %eax,-0x10(%ebp)
 967:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 96b:	75 23                	jne    990 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 96d:	c7 45 f0 60 0d 00 00 	movl   $0xd60,-0x10(%ebp)
 974:	8b 45 f0             	mov    -0x10(%ebp),%eax
 977:	a3 68 0d 00 00       	mov    %eax,0xd68
 97c:	a1 68 0d 00 00       	mov    0xd68,%eax
 981:	a3 60 0d 00 00       	mov    %eax,0xd60
    base.s.size = 0;
 986:	c7 05 64 0d 00 00 00 	movl   $0x0,0xd64
 98d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 990:	8b 45 f0             	mov    -0x10(%ebp),%eax
 993:	8b 00                	mov    (%eax),%eax
 995:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 998:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99b:	8b 40 04             	mov    0x4(%eax),%eax
 99e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9a1:	72 4d                	jb     9f0 <malloc+0xa6>
      if(p->s.size == nunits)
 9a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a6:	8b 40 04             	mov    0x4(%eax),%eax
 9a9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9ac:	75 0c                	jne    9ba <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b1:	8b 10                	mov    (%eax),%edx
 9b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9b6:	89 10                	mov    %edx,(%eax)
 9b8:	eb 26                	jmp    9e0 <malloc+0x96>
      else {
        p->s.size -= nunits;
 9ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bd:	8b 40 04             	mov    0x4(%eax),%eax
 9c0:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9c3:	89 c2                	mov    %eax,%edx
 9c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ce:	8b 40 04             	mov    0x4(%eax),%eax
 9d1:	c1 e0 03             	shl    $0x3,%eax
 9d4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9da:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9dd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e3:	a3 68 0d 00 00       	mov    %eax,0xd68
      return (void*)(p + 1);
 9e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9eb:	83 c0 08             	add    $0x8,%eax
 9ee:	eb 3b                	jmp    a2b <malloc+0xe1>
    }
    if(p == freep)
 9f0:	a1 68 0d 00 00       	mov    0xd68,%eax
 9f5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9f8:	75 1e                	jne    a18 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 9fa:	83 ec 0c             	sub    $0xc,%esp
 9fd:	ff 75 ec             	pushl  -0x14(%ebp)
 a00:	e8 e5 fe ff ff       	call   8ea <morecore>
 a05:	83 c4 10             	add    $0x10,%esp
 a08:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a0f:	75 07                	jne    a18 <malloc+0xce>
        return 0;
 a11:	b8 00 00 00 00       	mov    $0x0,%eax
 a16:	eb 13                	jmp    a2b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a21:	8b 00                	mov    (%eax),%eax
 a23:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a26:	e9 6d ff ff ff       	jmp    998 <malloc+0x4e>
}
 a2b:	c9                   	leave  
 a2c:	c3                   	ret    
