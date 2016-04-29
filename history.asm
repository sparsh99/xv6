
_history:     file format elf32-i386


Disassembly of section .text:

00000000 <history>:

char buf[1000];

void
history(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0){
   6:	eb 23                	jmp    2b <history+0x2b>
    write(1, buf, strlen(buf));
   8:	83 ec 0c             	sub    $0xc,%esp
   b:	68 60 0d 00 00       	push   $0xd60
  10:	e8 6b 01 00 00       	call   180 <strlen>
  15:	83 c4 10             	add    $0x10,%esp
  18:	83 ec 04             	sub    $0x4,%esp
  1b:	50                   	push   %eax
  1c:	68 60 0d 00 00       	push   $0xd60
  21:	6a 01                	push   $0x1
  23:	e8 d4 04 00 00       	call   4fc <write>
  28:	83 c4 10             	add    $0x10,%esp
void
history(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0){
  2b:	83 ec 04             	sub    $0x4,%esp
  2e:	68 e8 03 00 00       	push   $0x3e8
  33:	68 60 0d 00 00       	push   $0xd60
  38:	ff 75 08             	pushl  0x8(%ebp)
  3b:	e8 b4 04 00 00       	call   4f4 <read>
  40:	83 c4 10             	add    $0x10,%esp
  43:	89 45 f4             	mov    %eax,-0xc(%ebp)
  46:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  4a:	7f bc                	jg     8 <history+0x8>
    write(1, buf, strlen(buf));
	}
  if(n < 0){
  4c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  50:	79 17                	jns    69 <history+0x69>
    printf(1, "History: read error\n");
  52:	83 ec 08             	sub    $0x8,%esp
  55:	68 0c 0a 00 00       	push   $0xa0c
  5a:	6a 01                	push   $0x1
  5c:	e8 f2 05 00 00       	call   653 <printf>
  61:	83 c4 10             	add    $0x10,%esp
    exit();
  64:	e8 73 04 00 00       	call   4dc <exit>
  }
}
  69:	90                   	nop
  6a:	c9                   	leave  
  6b:	c3                   	ret    

0000006c <main>:

int
main(int argc, char *argv[])
{
  6c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  70:	83 e4 f0             	and    $0xfffffff0,%esp
  73:	ff 71 fc             	pushl  -0x4(%ecx)
  76:	55                   	push   %ebp
  77:	89 e5                	mov    %esp,%ebp
  79:	51                   	push   %ecx
  7a:	83 ec 14             	sub    $0x14,%esp
    int fd;

    char hist[10]={'h','\0'};
  7d:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
  84:	c7 45 ee 00 00 00 00 	movl   $0x0,-0x12(%ebp)
  8b:	66 c7 45 f2 00 00    	movw   $0x0,-0xe(%ebp)
  91:	c6 45 ea 68          	movb   $0x68,-0x16(%ebp)

    if((fd = open(hist, 0)) < 0){
  95:	83 ec 08             	sub    $0x8,%esp
  98:	6a 00                	push   $0x0
  9a:	8d 45 ea             	lea    -0x16(%ebp),%eax
  9d:	50                   	push   %eax
  9e:	e8 79 04 00 00       	call   51c <open>
  a3:	83 c4 10             	add    $0x10,%esp
  a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  ad:	79 1b                	jns    ca <main+0x5e>
      printf(1, "History: cannot open %s\n", hist);
  af:	83 ec 04             	sub    $0x4,%esp
  b2:	8d 45 ea             	lea    -0x16(%ebp),%eax
  b5:	50                   	push   %eax
  b6:	68 21 0a 00 00       	push   $0xa21
  bb:	6a 01                	push   $0x1
  bd:	e8 91 05 00 00       	call   653 <printf>
  c2:	83 c4 10             	add    $0x10,%esp
      exit();
  c5:	e8 12 04 00 00       	call   4dc <exit>
    }
    history(fd);
  ca:	83 ec 0c             	sub    $0xc,%esp
  cd:	ff 75 f4             	pushl  -0xc(%ebp)
  d0:	e8 2b ff ff ff       	call   0 <history>
  d5:	83 c4 10             	add    $0x10,%esp
    close(fd);
  d8:	83 ec 0c             	sub    $0xc,%esp
  db:	ff 75 f4             	pushl  -0xc(%ebp)
  de:	e8 21 04 00 00       	call   504 <close>
  e3:	83 c4 10             	add    $0x10,%esp
  exit();
  e6:	e8 f1 03 00 00       	call   4dc <exit>

000000eb <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  eb:	55                   	push   %ebp
  ec:	89 e5                	mov    %esp,%ebp
  ee:	57                   	push   %edi
  ef:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  f3:	8b 55 10             	mov    0x10(%ebp),%edx
  f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  f9:	89 cb                	mov    %ecx,%ebx
  fb:	89 df                	mov    %ebx,%edi
  fd:	89 d1                	mov    %edx,%ecx
  ff:	fc                   	cld    
 100:	f3 aa                	rep stos %al,%es:(%edi)
 102:	89 ca                	mov    %ecx,%edx
 104:	89 fb                	mov    %edi,%ebx
 106:	89 5d 08             	mov    %ebx,0x8(%ebp)
 109:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 10c:	90                   	nop
 10d:	5b                   	pop    %ebx
 10e:	5f                   	pop    %edi
 10f:	5d                   	pop    %ebp
 110:	c3                   	ret    

00000111 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 111:	55                   	push   %ebp
 112:	89 e5                	mov    %esp,%ebp
 114:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 11d:	90                   	nop
 11e:	8b 45 08             	mov    0x8(%ebp),%eax
 121:	8d 50 01             	lea    0x1(%eax),%edx
 124:	89 55 08             	mov    %edx,0x8(%ebp)
 127:	8b 55 0c             	mov    0xc(%ebp),%edx
 12a:	8d 4a 01             	lea    0x1(%edx),%ecx
 12d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 130:	0f b6 12             	movzbl (%edx),%edx
 133:	88 10                	mov    %dl,(%eax)
 135:	0f b6 00             	movzbl (%eax),%eax
 138:	84 c0                	test   %al,%al
 13a:	75 e2                	jne    11e <strcpy+0xd>
    ;
  return os;
 13c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13f:	c9                   	leave  
 140:	c3                   	ret    

00000141 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 144:	eb 08                	jmp    14e <strcmp+0xd>
    p++, q++;
 146:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 14a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
 151:	0f b6 00             	movzbl (%eax),%eax
 154:	84 c0                	test   %al,%al
 156:	74 10                	je     168 <strcmp+0x27>
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 10             	movzbl (%eax),%edx
 15e:	8b 45 0c             	mov    0xc(%ebp),%eax
 161:	0f b6 00             	movzbl (%eax),%eax
 164:	38 c2                	cmp    %al,%dl
 166:	74 de                	je     146 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	0f b6 00             	movzbl (%eax),%eax
 16e:	0f b6 d0             	movzbl %al,%edx
 171:	8b 45 0c             	mov    0xc(%ebp),%eax
 174:	0f b6 00             	movzbl (%eax),%eax
 177:	0f b6 c0             	movzbl %al,%eax
 17a:	29 c2                	sub    %eax,%edx
 17c:	89 d0                	mov    %edx,%eax
}
 17e:	5d                   	pop    %ebp
 17f:	c3                   	ret    

00000180 <strlen>:

uint
strlen(char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 186:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 18d:	eb 04                	jmp    193 <strlen+0x13>
 18f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 193:	8b 55 fc             	mov    -0x4(%ebp),%edx
 196:	8b 45 08             	mov    0x8(%ebp),%eax
 199:	01 d0                	add    %edx,%eax
 19b:	0f b6 00             	movzbl (%eax),%eax
 19e:	84 c0                	test   %al,%al
 1a0:	75 ed                	jne    18f <strlen+0xf>
    ;
  return n;
 1a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a5:	c9                   	leave  
 1a6:	c3                   	ret    

000001a7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a7:	55                   	push   %ebp
 1a8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1aa:	8b 45 10             	mov    0x10(%ebp),%eax
 1ad:	50                   	push   %eax
 1ae:	ff 75 0c             	pushl  0xc(%ebp)
 1b1:	ff 75 08             	pushl  0x8(%ebp)
 1b4:	e8 32 ff ff ff       	call   eb <stosb>
 1b9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1bf:	c9                   	leave  
 1c0:	c3                   	ret    

000001c1 <strchr>:

char*
strchr(const char *s, char c)
{
 1c1:	55                   	push   %ebp
 1c2:	89 e5                	mov    %esp,%ebp
 1c4:	83 ec 04             	sub    $0x4,%esp
 1c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ca:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1cd:	eb 14                	jmp    1e3 <strchr+0x22>
    if(*s == c)
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	0f b6 00             	movzbl (%eax),%eax
 1d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1d8:	75 05                	jne    1df <strchr+0x1e>
      return (char*)s;
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	eb 13                	jmp    1f2 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1df:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 00             	movzbl (%eax),%eax
 1e9:	84 c0                	test   %al,%al
 1eb:	75 e2                	jne    1cf <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1f2:	c9                   	leave  
 1f3:	c3                   	ret    

000001f4 <gets>:

char*
gets(char *buf, int max)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 201:	eb 42                	jmp    245 <gets+0x51>
    cc = read(0, &c, 1);
 203:	83 ec 04             	sub    $0x4,%esp
 206:	6a 01                	push   $0x1
 208:	8d 45 ef             	lea    -0x11(%ebp),%eax
 20b:	50                   	push   %eax
 20c:	6a 00                	push   $0x0
 20e:	e8 e1 02 00 00       	call   4f4 <read>
 213:	83 c4 10             	add    $0x10,%esp
 216:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 219:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 21d:	7e 33                	jle    252 <gets+0x5e>
      break;
    buf[i++] = c;
 21f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 222:	8d 50 01             	lea    0x1(%eax),%edx
 225:	89 55 f4             	mov    %edx,-0xc(%ebp)
 228:	89 c2                	mov    %eax,%edx
 22a:	8b 45 08             	mov    0x8(%ebp),%eax
 22d:	01 c2                	add    %eax,%edx
 22f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 233:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 235:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 16                	je     253 <gets+0x5f>
 23d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 241:	3c 0d                	cmp    $0xd,%al
 243:	74 0e                	je     253 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 245:	8b 45 f4             	mov    -0xc(%ebp),%eax
 248:	83 c0 01             	add    $0x1,%eax
 24b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 24e:	7c b3                	jl     203 <gets+0xf>
 250:	eb 01                	jmp    253 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 252:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 253:	8b 55 f4             	mov    -0xc(%ebp),%edx
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	01 d0                	add    %edx,%eax
 25b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 261:	c9                   	leave  
 262:	c3                   	ret    

00000263 <stat>:

int
stat(char *n, struct stat *st)
{
 263:	55                   	push   %ebp
 264:	89 e5                	mov    %esp,%ebp
 266:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 269:	83 ec 08             	sub    $0x8,%esp
 26c:	6a 00                	push   $0x0
 26e:	ff 75 08             	pushl  0x8(%ebp)
 271:	e8 a6 02 00 00       	call   51c <open>
 276:	83 c4 10             	add    $0x10,%esp
 279:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 27c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 280:	79 07                	jns    289 <stat+0x26>
    return -1;
 282:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 287:	eb 25                	jmp    2ae <stat+0x4b>
  r = fstat(fd, st);
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	ff 75 0c             	pushl  0xc(%ebp)
 28f:	ff 75 f4             	pushl  -0xc(%ebp)
 292:	e8 9d 02 00 00       	call   534 <fstat>
 297:	83 c4 10             	add    $0x10,%esp
 29a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 29d:	83 ec 0c             	sub    $0xc,%esp
 2a0:	ff 75 f4             	pushl  -0xc(%ebp)
 2a3:	e8 5c 02 00 00       	call   504 <close>
 2a8:	83 c4 10             	add    $0x10,%esp
  return r;
 2ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ae:	c9                   	leave  
 2af:	c3                   	ret    

000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2bd:	eb 25                	jmp    2e4 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c2:	89 d0                	mov    %edx,%eax
 2c4:	c1 e0 02             	shl    $0x2,%eax
 2c7:	01 d0                	add    %edx,%eax
 2c9:	01 c0                	add    %eax,%eax
 2cb:	89 c1                	mov    %eax,%ecx
 2cd:	8b 45 08             	mov    0x8(%ebp),%eax
 2d0:	8d 50 01             	lea    0x1(%eax),%edx
 2d3:	89 55 08             	mov    %edx,0x8(%ebp)
 2d6:	0f b6 00             	movzbl (%eax),%eax
 2d9:	0f be c0             	movsbl %al,%eax
 2dc:	01 c8                	add    %ecx,%eax
 2de:	83 e8 30             	sub    $0x30,%eax
 2e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e4:	8b 45 08             	mov    0x8(%ebp),%eax
 2e7:	0f b6 00             	movzbl (%eax),%eax
 2ea:	3c 2f                	cmp    $0x2f,%al
 2ec:	7e 0a                	jle    2f8 <atoi+0x48>
 2ee:	8b 45 08             	mov    0x8(%ebp),%eax
 2f1:	0f b6 00             	movzbl (%eax),%eax
 2f4:	3c 39                	cmp    $0x39,%al
 2f6:	7e c7                	jle    2bf <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2fb:	c9                   	leave  
 2fc:	c3                   	ret    

000002fd <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2fd:	55                   	push   %ebp
 2fe:	89 e5                	mov    %esp,%ebp
 300:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 309:	8b 45 0c             	mov    0xc(%ebp),%eax
 30c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 30f:	eb 17                	jmp    328 <memmove+0x2b>
    *dst++ = *src++;
 311:	8b 45 fc             	mov    -0x4(%ebp),%eax
 314:	8d 50 01             	lea    0x1(%eax),%edx
 317:	89 55 fc             	mov    %edx,-0x4(%ebp)
 31a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 31d:	8d 4a 01             	lea    0x1(%edx),%ecx
 320:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 323:	0f b6 12             	movzbl (%edx),%edx
 326:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 328:	8b 45 10             	mov    0x10(%ebp),%eax
 32b:	8d 50 ff             	lea    -0x1(%eax),%edx
 32e:	89 55 10             	mov    %edx,0x10(%ebp)
 331:	85 c0                	test   %eax,%eax
 333:	7f dc                	jg     311 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 335:	8b 45 08             	mov    0x8(%ebp),%eax
}
 338:	c9                   	leave  
 339:	c3                   	ret    

0000033a <historyAdd>:

void
historyAdd(char *buf1){
 33a:	55                   	push   %ebp
 33b:	89 e5                	mov    %esp,%ebp
 33d:	53                   	push   %ebx
 33e:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 344:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 34b:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 352:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 358:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 35c:	83 ec 08             	sub    $0x8,%esp
 35f:	6a 00                	push   $0x0
 361:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 364:	50                   	push   %eax
 365:	e8 b2 01 00 00       	call   51c <open>
 36a:	83 c4 10             	add    $0x10,%esp
 36d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 370:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 374:	79 1b                	jns    391 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 376:	83 ec 04             	sub    $0x4,%esp
 379:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 37c:	50                   	push   %eax
 37d:	68 3c 0a 00 00       	push   $0xa3c
 382:	6a 01                	push   $0x1
 384:	e8 ca 02 00 00       	call   653 <printf>
 389:	83 c4 10             	add    $0x10,%esp
       exit();
 38c:	e8 4b 01 00 00       	call   4dc <exit>
     }

     int i=0;
 391:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 398:	eb 1c                	jmp    3b6 <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 39a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 39d:	8b 45 08             	mov    0x8(%ebp),%eax
 3a0:	01 d0                	add    %edx,%eax
 3a2:	0f b6 00             	movzbl (%eax),%eax
 3a5:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 3ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3ae:	01 ca                	add    %ecx,%edx
 3b0:	88 02                	mov    %al,(%edx)
	i++;
 3b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 3b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3b9:	8b 45 08             	mov    0x8(%ebp),%eax
 3bc:	01 d0                	add    %edx,%eax
 3be:	0f b6 00             	movzbl (%eax),%eax
 3c1:	84 c0                	test   %al,%al
 3c3:	75 d5                	jne    39a <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 3c5:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 3cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ce:	01 d0                	add    %edx,%eax
 3d0:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3d3:	eb 5a                	jmp    42f <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 3d5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 3d8:	83 ec 0c             	sub    $0xc,%esp
 3db:	ff 75 08             	pushl  0x8(%ebp)
 3de:	e8 9d fd ff ff       	call   180 <strlen>
 3e3:	83 c4 10             	add    $0x10,%esp
 3e6:	29 c3                	sub    %eax,%ebx
 3e8:	89 d8                	mov    %ebx,%eax
 3ea:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 3f1:	ff 
 3f2:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 3f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3fb:	01 ca                	add    %ecx,%edx
 3fd:	88 02                	mov    %al,(%edx)
		i++;
 3ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 403:	83 ec 0c             	sub    $0xc,%esp
 406:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 40c:	50                   	push   %eax
 40d:	e8 6e fd ff ff       	call   180 <strlen>
 412:	83 c4 10             	add    $0x10,%esp
 415:	89 c3                	mov    %eax,%ebx
 417:	83 ec 0c             	sub    $0xc,%esp
 41a:	ff 75 08             	pushl  0x8(%ebp)
 41d:	e8 5e fd ff ff       	call   180 <strlen>
 422:	83 c4 10             	add    $0x10,%esp
 425:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 428:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42b:	39 c2                	cmp    %eax,%edx
 42d:	77 a6                	ja     3d5 <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 42f:	83 ec 04             	sub    $0x4,%esp
 432:	68 e8 03 00 00       	push   $0x3e8
 437:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 43d:	50                   	push   %eax
 43e:	ff 75 f0             	pushl  -0x10(%ebp)
 441:	e8 ae 00 00 00       	call   4f4 <read>
 446:	83 c4 10             	add    $0x10,%esp
 449:	85 c0                	test   %eax,%eax
 44b:	7f b6                	jg     403 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 44d:	83 ec 0c             	sub    $0xc,%esp
 450:	ff 75 f0             	pushl  -0x10(%ebp)
 453:	e8 ac 00 00 00       	call   504 <close>
 458:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 45b:	83 ec 08             	sub    $0x8,%esp
 45e:	68 02 02 00 00       	push   $0x202
 463:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 466:	50                   	push   %eax
 467:	e8 b0 00 00 00       	call   51c <open>
 46c:	83 c4 10             	add    $0x10,%esp
 46f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 472:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 476:	79 1b                	jns    493 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 478:	83 ec 04             	sub    $0x4,%esp
 47b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 47e:	50                   	push   %eax
 47f:	68 3c 0a 00 00       	push   $0xa3c
 484:	6a 01                	push   $0x1
 486:	e8 c8 01 00 00       	call   653 <printf>
 48b:	83 c4 10             	add    $0x10,%esp
       exit();
 48e:	e8 49 00 00 00       	call   4dc <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 493:	83 ec 04             	sub    $0x4,%esp
 496:	68 e8 03 00 00       	push   $0x3e8
 49b:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 4a1:	50                   	push   %eax
 4a2:	ff 75 f0             	pushl  -0x10(%ebp)
 4a5:	e8 52 00 00 00       	call   4fc <write>
 4aa:	83 c4 10             	add    $0x10,%esp
 4ad:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 4b2:	74 1a                	je     4ce <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 4b4:	83 ec 04             	sub    $0x4,%esp
 4b7:	ff 75 f4             	pushl  -0xc(%ebp)
 4ba:	68 58 0a 00 00       	push   $0xa58
 4bf:	6a 01                	push   $0x1
 4c1:	e8 8d 01 00 00       	call   653 <printf>
 4c6:	83 c4 10             	add    $0x10,%esp
       exit();
 4c9:	e8 0e 00 00 00       	call   4dc <exit>
     }
    
}
 4ce:	90                   	nop
 4cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4d2:	c9                   	leave  
 4d3:	c3                   	ret    

000004d4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4d4:	b8 01 00 00 00       	mov    $0x1,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <exit>:
SYSCALL(exit)
 4dc:	b8 02 00 00 00       	mov    $0x2,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <wait>:
SYSCALL(wait)
 4e4:	b8 03 00 00 00       	mov    $0x3,%eax
 4e9:	cd 40                	int    $0x40
 4eb:	c3                   	ret    

000004ec <pipe>:
SYSCALL(pipe)
 4ec:	b8 04 00 00 00       	mov    $0x4,%eax
 4f1:	cd 40                	int    $0x40
 4f3:	c3                   	ret    

000004f4 <read>:
SYSCALL(read)
 4f4:	b8 05 00 00 00       	mov    $0x5,%eax
 4f9:	cd 40                	int    $0x40
 4fb:	c3                   	ret    

000004fc <write>:
SYSCALL(write)
 4fc:	b8 10 00 00 00       	mov    $0x10,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <close>:
SYSCALL(close)
 504:	b8 15 00 00 00       	mov    $0x15,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <kill>:
SYSCALL(kill)
 50c:	b8 06 00 00 00       	mov    $0x6,%eax
 511:	cd 40                	int    $0x40
 513:	c3                   	ret    

00000514 <exec>:
SYSCALL(exec)
 514:	b8 07 00 00 00       	mov    $0x7,%eax
 519:	cd 40                	int    $0x40
 51b:	c3                   	ret    

0000051c <open>:
SYSCALL(open)
 51c:	b8 0f 00 00 00       	mov    $0xf,%eax
 521:	cd 40                	int    $0x40
 523:	c3                   	ret    

00000524 <mknod>:
SYSCALL(mknod)
 524:	b8 11 00 00 00       	mov    $0x11,%eax
 529:	cd 40                	int    $0x40
 52b:	c3                   	ret    

0000052c <unlink>:
SYSCALL(unlink)
 52c:	b8 12 00 00 00       	mov    $0x12,%eax
 531:	cd 40                	int    $0x40
 533:	c3                   	ret    

00000534 <fstat>:
SYSCALL(fstat)
 534:	b8 08 00 00 00       	mov    $0x8,%eax
 539:	cd 40                	int    $0x40
 53b:	c3                   	ret    

0000053c <link>:
SYSCALL(link)
 53c:	b8 13 00 00 00       	mov    $0x13,%eax
 541:	cd 40                	int    $0x40
 543:	c3                   	ret    

00000544 <mkdir>:
SYSCALL(mkdir)
 544:	b8 14 00 00 00       	mov    $0x14,%eax
 549:	cd 40                	int    $0x40
 54b:	c3                   	ret    

0000054c <chdir>:
SYSCALL(chdir)
 54c:	b8 09 00 00 00       	mov    $0x9,%eax
 551:	cd 40                	int    $0x40
 553:	c3                   	ret    

00000554 <dup>:
SYSCALL(dup)
 554:	b8 0a 00 00 00       	mov    $0xa,%eax
 559:	cd 40                	int    $0x40
 55b:	c3                   	ret    

0000055c <getpid>:
SYSCALL(getpid)
 55c:	b8 0b 00 00 00       	mov    $0xb,%eax
 561:	cd 40                	int    $0x40
 563:	c3                   	ret    

00000564 <sbrk>:
SYSCALL(sbrk)
 564:	b8 0c 00 00 00       	mov    $0xc,%eax
 569:	cd 40                	int    $0x40
 56b:	c3                   	ret    

0000056c <sleep>:
SYSCALL(sleep)
 56c:	b8 0d 00 00 00       	mov    $0xd,%eax
 571:	cd 40                	int    $0x40
 573:	c3                   	ret    

00000574 <uptime>:
SYSCALL(uptime)
 574:	b8 0e 00 00 00       	mov    $0xe,%eax
 579:	cd 40                	int    $0x40
 57b:	c3                   	ret    

0000057c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 57c:	55                   	push   %ebp
 57d:	89 e5                	mov    %esp,%ebp
 57f:	83 ec 18             	sub    $0x18,%esp
 582:	8b 45 0c             	mov    0xc(%ebp),%eax
 585:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 588:	83 ec 04             	sub    $0x4,%esp
 58b:	6a 01                	push   $0x1
 58d:	8d 45 f4             	lea    -0xc(%ebp),%eax
 590:	50                   	push   %eax
 591:	ff 75 08             	pushl  0x8(%ebp)
 594:	e8 63 ff ff ff       	call   4fc <write>
 599:	83 c4 10             	add    $0x10,%esp
}
 59c:	90                   	nop
 59d:	c9                   	leave  
 59e:	c3                   	ret    

0000059f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 59f:	55                   	push   %ebp
 5a0:	89 e5                	mov    %esp,%ebp
 5a2:	53                   	push   %ebx
 5a3:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5a6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5ad:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5b1:	74 17                	je     5ca <printint+0x2b>
 5b3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5b7:	79 11                	jns    5ca <printint+0x2b>
    neg = 1;
 5b9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c3:	f7 d8                	neg    %eax
 5c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5c8:	eb 06                	jmp    5d0 <printint+0x31>
  } else {
    x = xx;
 5ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 5cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5d7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 5da:	8d 41 01             	lea    0x1(%ecx),%eax
 5dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5e0:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5e6:	ba 00 00 00 00       	mov    $0x0,%edx
 5eb:	f7 f3                	div    %ebx
 5ed:	89 d0                	mov    %edx,%eax
 5ef:	0f b6 80 10 0d 00 00 	movzbl 0xd10(%eax),%eax
 5f6:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 5fa:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 600:	ba 00 00 00 00       	mov    $0x0,%edx
 605:	f7 f3                	div    %ebx
 607:	89 45 ec             	mov    %eax,-0x14(%ebp)
 60a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 60e:	75 c7                	jne    5d7 <printint+0x38>
  if(neg)
 610:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 614:	74 2d                	je     643 <printint+0xa4>
    buf[i++] = '-';
 616:	8b 45 f4             	mov    -0xc(%ebp),%eax
 619:	8d 50 01             	lea    0x1(%eax),%edx
 61c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 61f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 624:	eb 1d                	jmp    643 <printint+0xa4>
    putc(fd, buf[i]);
 626:	8d 55 dc             	lea    -0x24(%ebp),%edx
 629:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62c:	01 d0                	add    %edx,%eax
 62e:	0f b6 00             	movzbl (%eax),%eax
 631:	0f be c0             	movsbl %al,%eax
 634:	83 ec 08             	sub    $0x8,%esp
 637:	50                   	push   %eax
 638:	ff 75 08             	pushl  0x8(%ebp)
 63b:	e8 3c ff ff ff       	call   57c <putc>
 640:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 643:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 647:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 64b:	79 d9                	jns    626 <printint+0x87>
    putc(fd, buf[i]);
}
 64d:	90                   	nop
 64e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 651:	c9                   	leave  
 652:	c3                   	ret    

00000653 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 653:	55                   	push   %ebp
 654:	89 e5                	mov    %esp,%ebp
 656:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 659:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 660:	8d 45 0c             	lea    0xc(%ebp),%eax
 663:	83 c0 04             	add    $0x4,%eax
 666:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 669:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 670:	e9 59 01 00 00       	jmp    7ce <printf+0x17b>
    c = fmt[i] & 0xff;
 675:	8b 55 0c             	mov    0xc(%ebp),%edx
 678:	8b 45 f0             	mov    -0x10(%ebp),%eax
 67b:	01 d0                	add    %edx,%eax
 67d:	0f b6 00             	movzbl (%eax),%eax
 680:	0f be c0             	movsbl %al,%eax
 683:	25 ff 00 00 00       	and    $0xff,%eax
 688:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 68b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 68f:	75 2c                	jne    6bd <printf+0x6a>
      if(c == '%'){
 691:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 695:	75 0c                	jne    6a3 <printf+0x50>
        state = '%';
 697:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 69e:	e9 27 01 00 00       	jmp    7ca <printf+0x177>
      } else {
        putc(fd, c);
 6a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a6:	0f be c0             	movsbl %al,%eax
 6a9:	83 ec 08             	sub    $0x8,%esp
 6ac:	50                   	push   %eax
 6ad:	ff 75 08             	pushl  0x8(%ebp)
 6b0:	e8 c7 fe ff ff       	call   57c <putc>
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	e9 0d 01 00 00       	jmp    7ca <printf+0x177>
      }
    } else if(state == '%'){
 6bd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6c1:	0f 85 03 01 00 00    	jne    7ca <printf+0x177>
      if(c == 'd'){
 6c7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6cb:	75 1e                	jne    6eb <printf+0x98>
        printint(fd, *ap, 10, 1);
 6cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d0:	8b 00                	mov    (%eax),%eax
 6d2:	6a 01                	push   $0x1
 6d4:	6a 0a                	push   $0xa
 6d6:	50                   	push   %eax
 6d7:	ff 75 08             	pushl  0x8(%ebp)
 6da:	e8 c0 fe ff ff       	call   59f <printint>
 6df:	83 c4 10             	add    $0x10,%esp
        ap++;
 6e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6e6:	e9 d8 00 00 00       	jmp    7c3 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 6eb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6ef:	74 06                	je     6f7 <printf+0xa4>
 6f1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6f5:	75 1e                	jne    715 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 6f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6fa:	8b 00                	mov    (%eax),%eax
 6fc:	6a 00                	push   $0x0
 6fe:	6a 10                	push   $0x10
 700:	50                   	push   %eax
 701:	ff 75 08             	pushl  0x8(%ebp)
 704:	e8 96 fe ff ff       	call   59f <printint>
 709:	83 c4 10             	add    $0x10,%esp
        ap++;
 70c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 710:	e9 ae 00 00 00       	jmp    7c3 <printf+0x170>
      } else if(c == 's'){
 715:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 719:	75 43                	jne    75e <printf+0x10b>
        s = (char*)*ap;
 71b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 71e:	8b 00                	mov    (%eax),%eax
 720:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 723:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 727:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 72b:	75 25                	jne    752 <printf+0xff>
          s = "(null)";
 72d:	c7 45 f4 7c 0a 00 00 	movl   $0xa7c,-0xc(%ebp)
        while(*s != 0){
 734:	eb 1c                	jmp    752 <printf+0xff>
          putc(fd, *s);
 736:	8b 45 f4             	mov    -0xc(%ebp),%eax
 739:	0f b6 00             	movzbl (%eax),%eax
 73c:	0f be c0             	movsbl %al,%eax
 73f:	83 ec 08             	sub    $0x8,%esp
 742:	50                   	push   %eax
 743:	ff 75 08             	pushl  0x8(%ebp)
 746:	e8 31 fe ff ff       	call   57c <putc>
 74b:	83 c4 10             	add    $0x10,%esp
          s++;
 74e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 752:	8b 45 f4             	mov    -0xc(%ebp),%eax
 755:	0f b6 00             	movzbl (%eax),%eax
 758:	84 c0                	test   %al,%al
 75a:	75 da                	jne    736 <printf+0xe3>
 75c:	eb 65                	jmp    7c3 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 75e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 762:	75 1d                	jne    781 <printf+0x12e>
        putc(fd, *ap);
 764:	8b 45 e8             	mov    -0x18(%ebp),%eax
 767:	8b 00                	mov    (%eax),%eax
 769:	0f be c0             	movsbl %al,%eax
 76c:	83 ec 08             	sub    $0x8,%esp
 76f:	50                   	push   %eax
 770:	ff 75 08             	pushl  0x8(%ebp)
 773:	e8 04 fe ff ff       	call   57c <putc>
 778:	83 c4 10             	add    $0x10,%esp
        ap++;
 77b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 77f:	eb 42                	jmp    7c3 <printf+0x170>
      } else if(c == '%'){
 781:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 785:	75 17                	jne    79e <printf+0x14b>
        putc(fd, c);
 787:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 78a:	0f be c0             	movsbl %al,%eax
 78d:	83 ec 08             	sub    $0x8,%esp
 790:	50                   	push   %eax
 791:	ff 75 08             	pushl  0x8(%ebp)
 794:	e8 e3 fd ff ff       	call   57c <putc>
 799:	83 c4 10             	add    $0x10,%esp
 79c:	eb 25                	jmp    7c3 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 79e:	83 ec 08             	sub    $0x8,%esp
 7a1:	6a 25                	push   $0x25
 7a3:	ff 75 08             	pushl  0x8(%ebp)
 7a6:	e8 d1 fd ff ff       	call   57c <putc>
 7ab:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 7ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b1:	0f be c0             	movsbl %al,%eax
 7b4:	83 ec 08             	sub    $0x8,%esp
 7b7:	50                   	push   %eax
 7b8:	ff 75 08             	pushl  0x8(%ebp)
 7bb:	e8 bc fd ff ff       	call   57c <putc>
 7c0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7c3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7ca:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7ce:	8b 55 0c             	mov    0xc(%ebp),%edx
 7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d4:	01 d0                	add    %edx,%eax
 7d6:	0f b6 00             	movzbl (%eax),%eax
 7d9:	84 c0                	test   %al,%al
 7db:	0f 85 94 fe ff ff    	jne    675 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7e1:	90                   	nop
 7e2:	c9                   	leave  
 7e3:	c3                   	ret    

000007e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e4:	55                   	push   %ebp
 7e5:	89 e5                	mov    %esp,%ebp
 7e7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ea:	8b 45 08             	mov    0x8(%ebp),%eax
 7ed:	83 e8 08             	sub    $0x8,%eax
 7f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f3:	a1 48 0d 00 00       	mov    0xd48,%eax
 7f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7fb:	eb 24                	jmp    821 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 800:	8b 00                	mov    (%eax),%eax
 802:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 805:	77 12                	ja     819 <free+0x35>
 807:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 80d:	77 24                	ja     833 <free+0x4f>
 80f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 817:	77 1a                	ja     833 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81c:	8b 00                	mov    (%eax),%eax
 81e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 821:	8b 45 f8             	mov    -0x8(%ebp),%eax
 824:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 827:	76 d4                	jbe    7fd <free+0x19>
 829:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82c:	8b 00                	mov    (%eax),%eax
 82e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 831:	76 ca                	jbe    7fd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 833:	8b 45 f8             	mov    -0x8(%ebp),%eax
 836:	8b 40 04             	mov    0x4(%eax),%eax
 839:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 840:	8b 45 f8             	mov    -0x8(%ebp),%eax
 843:	01 c2                	add    %eax,%edx
 845:	8b 45 fc             	mov    -0x4(%ebp),%eax
 848:	8b 00                	mov    (%eax),%eax
 84a:	39 c2                	cmp    %eax,%edx
 84c:	75 24                	jne    872 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 84e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 851:	8b 50 04             	mov    0x4(%eax),%edx
 854:	8b 45 fc             	mov    -0x4(%ebp),%eax
 857:	8b 00                	mov    (%eax),%eax
 859:	8b 40 04             	mov    0x4(%eax),%eax
 85c:	01 c2                	add    %eax,%edx
 85e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 861:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 864:	8b 45 fc             	mov    -0x4(%ebp),%eax
 867:	8b 00                	mov    (%eax),%eax
 869:	8b 10                	mov    (%eax),%edx
 86b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 86e:	89 10                	mov    %edx,(%eax)
 870:	eb 0a                	jmp    87c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 872:	8b 45 fc             	mov    -0x4(%ebp),%eax
 875:	8b 10                	mov    (%eax),%edx
 877:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 87c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87f:	8b 40 04             	mov    0x4(%eax),%eax
 882:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 889:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88c:	01 d0                	add    %edx,%eax
 88e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 891:	75 20                	jne    8b3 <free+0xcf>
    p->s.size += bp->s.size;
 893:	8b 45 fc             	mov    -0x4(%ebp),%eax
 896:	8b 50 04             	mov    0x4(%eax),%edx
 899:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89c:	8b 40 04             	mov    0x4(%eax),%eax
 89f:	01 c2                	add    %eax,%edx
 8a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8aa:	8b 10                	mov    (%eax),%edx
 8ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8af:	89 10                	mov    %edx,(%eax)
 8b1:	eb 08                	jmp    8bb <free+0xd7>
  } else
    p->s.ptr = bp;
 8b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8b9:	89 10                	mov    %edx,(%eax)
  freep = p;
 8bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8be:	a3 48 0d 00 00       	mov    %eax,0xd48
}
 8c3:	90                   	nop
 8c4:	c9                   	leave  
 8c5:	c3                   	ret    

000008c6 <morecore>:

static Header*
morecore(uint nu)
{
 8c6:	55                   	push   %ebp
 8c7:	89 e5                	mov    %esp,%ebp
 8c9:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8cc:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8d3:	77 07                	ja     8dc <morecore+0x16>
    nu = 4096;
 8d5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8dc:	8b 45 08             	mov    0x8(%ebp),%eax
 8df:	c1 e0 03             	shl    $0x3,%eax
 8e2:	83 ec 0c             	sub    $0xc,%esp
 8e5:	50                   	push   %eax
 8e6:	e8 79 fc ff ff       	call   564 <sbrk>
 8eb:	83 c4 10             	add    $0x10,%esp
 8ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8f1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8f5:	75 07                	jne    8fe <morecore+0x38>
    return 0;
 8f7:	b8 00 00 00 00       	mov    $0x0,%eax
 8fc:	eb 26                	jmp    924 <morecore+0x5e>
  hp = (Header*)p;
 8fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 901:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 904:	8b 45 f0             	mov    -0x10(%ebp),%eax
 907:	8b 55 08             	mov    0x8(%ebp),%edx
 90a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 90d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 910:	83 c0 08             	add    $0x8,%eax
 913:	83 ec 0c             	sub    $0xc,%esp
 916:	50                   	push   %eax
 917:	e8 c8 fe ff ff       	call   7e4 <free>
 91c:	83 c4 10             	add    $0x10,%esp
  return freep;
 91f:	a1 48 0d 00 00       	mov    0xd48,%eax
}
 924:	c9                   	leave  
 925:	c3                   	ret    

00000926 <malloc>:

void*
malloc(uint nbytes)
{
 926:	55                   	push   %ebp
 927:	89 e5                	mov    %esp,%ebp
 929:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 92c:	8b 45 08             	mov    0x8(%ebp),%eax
 92f:	83 c0 07             	add    $0x7,%eax
 932:	c1 e8 03             	shr    $0x3,%eax
 935:	83 c0 01             	add    $0x1,%eax
 938:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 93b:	a1 48 0d 00 00       	mov    0xd48,%eax
 940:	89 45 f0             	mov    %eax,-0x10(%ebp)
 943:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 947:	75 23                	jne    96c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 949:	c7 45 f0 40 0d 00 00 	movl   $0xd40,-0x10(%ebp)
 950:	8b 45 f0             	mov    -0x10(%ebp),%eax
 953:	a3 48 0d 00 00       	mov    %eax,0xd48
 958:	a1 48 0d 00 00       	mov    0xd48,%eax
 95d:	a3 40 0d 00 00       	mov    %eax,0xd40
    base.s.size = 0;
 962:	c7 05 44 0d 00 00 00 	movl   $0x0,0xd44
 969:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 96f:	8b 00                	mov    (%eax),%eax
 971:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 974:	8b 45 f4             	mov    -0xc(%ebp),%eax
 977:	8b 40 04             	mov    0x4(%eax),%eax
 97a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 97d:	72 4d                	jb     9cc <malloc+0xa6>
      if(p->s.size == nunits)
 97f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 982:	8b 40 04             	mov    0x4(%eax),%eax
 985:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 988:	75 0c                	jne    996 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 98a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98d:	8b 10                	mov    (%eax),%edx
 98f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 992:	89 10                	mov    %edx,(%eax)
 994:	eb 26                	jmp    9bc <malloc+0x96>
      else {
        p->s.size -= nunits;
 996:	8b 45 f4             	mov    -0xc(%ebp),%eax
 999:	8b 40 04             	mov    0x4(%eax),%eax
 99c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 99f:	89 c2                	mov    %eax,%edx
 9a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9aa:	8b 40 04             	mov    0x4(%eax),%eax
 9ad:	c1 e0 03             	shl    $0x3,%eax
 9b0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b6:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9b9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9bf:	a3 48 0d 00 00       	mov    %eax,0xd48
      return (void*)(p + 1);
 9c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c7:	83 c0 08             	add    $0x8,%eax
 9ca:	eb 3b                	jmp    a07 <malloc+0xe1>
    }
    if(p == freep)
 9cc:	a1 48 0d 00 00       	mov    0xd48,%eax
 9d1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9d4:	75 1e                	jne    9f4 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 9d6:	83 ec 0c             	sub    $0xc,%esp
 9d9:	ff 75 ec             	pushl  -0x14(%ebp)
 9dc:	e8 e5 fe ff ff       	call   8c6 <morecore>
 9e1:	83 c4 10             	add    $0x10,%esp
 9e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9eb:	75 07                	jne    9f4 <malloc+0xce>
        return 0;
 9ed:	b8 00 00 00 00       	mov    $0x0,%eax
 9f2:	eb 13                	jmp    a07 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fd:	8b 00                	mov    (%eax),%eax
 9ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a02:	e9 6d ff ff ff       	jmp    974 <malloc+0x4e>
}
 a07:	c9                   	leave  
 a08:	c3                   	ret    
