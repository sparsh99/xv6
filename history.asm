
_history:     file format elf32-i386


Disassembly of section .text:

00000000 <history>:

char buf[512];

void
history(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 15                	jmp    1d <history+0x1d>
    write(1, buf, n);
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	pushl  -0xc(%ebp)
   e:	68 80 0b 00 00       	push   $0xb80
  13:	6a 01                	push   $0x1
  15:	e8 68 03 00 00       	call   382 <write>
  1a:	83 c4 10             	add    $0x10,%esp
void
history(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  1d:	83 ec 04             	sub    $0x4,%esp
  20:	68 00 02 00 00       	push   $0x200
  25:	68 80 0b 00 00       	push   $0xb80
  2a:	ff 75 08             	pushl  0x8(%ebp)
  2d:	e8 48 03 00 00       	call   37a <read>
  32:	83 c4 10             	add    $0x10,%esp
  35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  3c:	7f ca                	jg     8 <history+0x8>
    write(1, buf, n);
  if(n < 0){
  3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  42:	79 17                	jns    5b <history+0x5b>
    printf(1, "History: read error\n");
  44:	83 ec 08             	sub    $0x8,%esp
  47:	68 8f 08 00 00       	push   $0x88f
  4c:	6a 01                	push   $0x1
  4e:	e8 86 04 00 00       	call   4d9 <printf>
  53:	83 c4 10             	add    $0x10,%esp
    exit();
  56:	e8 07 03 00 00       	call   362 <exit>
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
  6d:	83 ec 20             	sub    $0x20,%esp
  70:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  72:	83 3b 01             	cmpl   $0x1,(%ebx)
  75:	7f 12                	jg     89 <main+0x2b>
    history(0);
  77:	83 ec 0c             	sub    $0xc,%esp
  7a:	6a 00                	push   $0x0
  7c:	e8 7f ff ff ff       	call   0 <history>
  81:	83 c4 10             	add    $0x10,%esp
    exit();
  84:	e8 d9 02 00 00       	call   362 <exit>
  }
  char hist[10]={'h','\0'};
  89:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
  90:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
  97:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
  9d:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
  for(i = 1; i < argc; i++){
  a1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  a8:	eb 55                	jmp    ff <main+0xa1>
    if((fd = open(hist, 0)) < 0){
  aa:	83 ec 08             	sub    $0x8,%esp
  ad:	6a 00                	push   $0x0
  af:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  b2:	50                   	push   %eax
  b3:	e8 ea 02 00 00       	call   3a2 <open>
  b8:	83 c4 10             	add    $0x10,%esp
  bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  c2:	79 1b                	jns    df <main+0x81>
      printf(1, "History: cannot open %s\n", hist);
  c4:	83 ec 04             	sub    $0x4,%esp
  c7:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  ca:	50                   	push   %eax
  cb:	68 a4 08 00 00       	push   $0x8a4
  d0:	6a 01                	push   $0x1
  d2:	e8 02 04 00 00       	call   4d9 <printf>
  d7:	83 c4 10             	add    $0x10,%esp
      exit();
  da:	e8 83 02 00 00       	call   362 <exit>
    }
    history(fd);
  df:	83 ec 0c             	sub    $0xc,%esp
  e2:	ff 75 f0             	pushl  -0x10(%ebp)
  e5:	e8 16 ff ff ff       	call   0 <history>
  ea:	83 c4 10             	add    $0x10,%esp
    close(fd);
  ed:	83 ec 0c             	sub    $0xc,%esp
  f0:	ff 75 f0             	pushl  -0x10(%ebp)
  f3:	e8 92 02 00 00       	call   38a <close>
  f8:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    history(0);
    exit();
  }
  char hist[10]={'h','\0'};
  for(i = 1; i < argc; i++){
  fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 102:	3b 03                	cmp    (%ebx),%eax
 104:	7c a4                	jl     aa <main+0x4c>
      exit();
    }
    history(fd);
    close(fd);
  }
  exit();
 106:	e8 57 02 00 00       	call   362 <exit>

0000010b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 10b:	55                   	push   %ebp
 10c:	89 e5                	mov    %esp,%ebp
 10e:	57                   	push   %edi
 10f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 110:	8b 4d 08             	mov    0x8(%ebp),%ecx
 113:	8b 55 10             	mov    0x10(%ebp),%edx
 116:	8b 45 0c             	mov    0xc(%ebp),%eax
 119:	89 cb                	mov    %ecx,%ebx
 11b:	89 df                	mov    %ebx,%edi
 11d:	89 d1                	mov    %edx,%ecx
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
 122:	89 ca                	mov    %ecx,%edx
 124:	89 fb                	mov    %edi,%ebx
 126:	89 5d 08             	mov    %ebx,0x8(%ebp)
 129:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 12c:	90                   	nop
 12d:	5b                   	pop    %ebx
 12e:	5f                   	pop    %edi
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    

00000131 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 131:	55                   	push   %ebp
 132:	89 e5                	mov    %esp,%ebp
 134:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 13d:	90                   	nop
 13e:	8b 45 08             	mov    0x8(%ebp),%eax
 141:	8d 50 01             	lea    0x1(%eax),%edx
 144:	89 55 08             	mov    %edx,0x8(%ebp)
 147:	8b 55 0c             	mov    0xc(%ebp),%edx
 14a:	8d 4a 01             	lea    0x1(%edx),%ecx
 14d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 150:	0f b6 12             	movzbl (%edx),%edx
 153:	88 10                	mov    %dl,(%eax)
 155:	0f b6 00             	movzbl (%eax),%eax
 158:	84 c0                	test   %al,%al
 15a:	75 e2                	jne    13e <strcpy+0xd>
    ;
  return os;
 15c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15f:	c9                   	leave  
 160:	c3                   	ret    

00000161 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 161:	55                   	push   %ebp
 162:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 164:	eb 08                	jmp    16e <strcmp+0xd>
    p++, q++;
 166:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	0f b6 00             	movzbl (%eax),%eax
 174:	84 c0                	test   %al,%al
 176:	74 10                	je     188 <strcmp+0x27>
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	0f b6 10             	movzbl (%eax),%edx
 17e:	8b 45 0c             	mov    0xc(%ebp),%eax
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	38 c2                	cmp    %al,%dl
 186:	74 de                	je     166 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	0f b6 00             	movzbl (%eax),%eax
 18e:	0f b6 d0             	movzbl %al,%edx
 191:	8b 45 0c             	mov    0xc(%ebp),%eax
 194:	0f b6 00             	movzbl (%eax),%eax
 197:	0f b6 c0             	movzbl %al,%eax
 19a:	29 c2                	sub    %eax,%edx
 19c:	89 d0                	mov    %edx,%eax
}
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    

000001a0 <strlen>:

uint
strlen(char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1ad:	eb 04                	jmp    1b3 <strlen+0x13>
 1af:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
 1b9:	01 d0                	add    %edx,%eax
 1bb:	0f b6 00             	movzbl (%eax),%eax
 1be:	84 c0                	test   %al,%al
 1c0:	75 ed                	jne    1af <strlen+0xf>
    ;
  return n;
 1c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c5:	c9                   	leave  
 1c6:	c3                   	ret    

000001c7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c7:	55                   	push   %ebp
 1c8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1ca:	8b 45 10             	mov    0x10(%ebp),%eax
 1cd:	50                   	push   %eax
 1ce:	ff 75 0c             	pushl  0xc(%ebp)
 1d1:	ff 75 08             	pushl  0x8(%ebp)
 1d4:	e8 32 ff ff ff       	call   10b <stosb>
 1d9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1df:	c9                   	leave  
 1e0:	c3                   	ret    

000001e1 <strchr>:

char*
strchr(const char *s, char c)
{
 1e1:	55                   	push   %ebp
 1e2:	89 e5                	mov    %esp,%ebp
 1e4:	83 ec 04             	sub    $0x4,%esp
 1e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ea:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1ed:	eb 14                	jmp    203 <strchr+0x22>
    if(*s == c)
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	0f b6 00             	movzbl (%eax),%eax
 1f5:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1f8:	75 05                	jne    1ff <strchr+0x1e>
      return (char*)s;
 1fa:	8b 45 08             	mov    0x8(%ebp),%eax
 1fd:	eb 13                	jmp    212 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1ff:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 00             	movzbl (%eax),%eax
 209:	84 c0                	test   %al,%al
 20b:	75 e2                	jne    1ef <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 20d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 212:	c9                   	leave  
 213:	c3                   	ret    

00000214 <gets>:

char*
gets(char *buf, int max)
{
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 221:	eb 42                	jmp    265 <gets+0x51>
    cc = read(0, &c, 1);
 223:	83 ec 04             	sub    $0x4,%esp
 226:	6a 01                	push   $0x1
 228:	8d 45 ef             	lea    -0x11(%ebp),%eax
 22b:	50                   	push   %eax
 22c:	6a 00                	push   $0x0
 22e:	e8 47 01 00 00       	call   37a <read>
 233:	83 c4 10             	add    $0x10,%esp
 236:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 239:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 23d:	7e 33                	jle    272 <gets+0x5e>
      break;
    buf[i++] = c;
 23f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 242:	8d 50 01             	lea    0x1(%eax),%edx
 245:	89 55 f4             	mov    %edx,-0xc(%ebp)
 248:	89 c2                	mov    %eax,%edx
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	01 c2                	add    %eax,%edx
 24f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 253:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 255:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 259:	3c 0a                	cmp    $0xa,%al
 25b:	74 16                	je     273 <gets+0x5f>
 25d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 261:	3c 0d                	cmp    $0xd,%al
 263:	74 0e                	je     273 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 265:	8b 45 f4             	mov    -0xc(%ebp),%eax
 268:	83 c0 01             	add    $0x1,%eax
 26b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 26e:	7c b3                	jl     223 <gets+0xf>
 270:	eb 01                	jmp    273 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 272:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 273:	8b 55 f4             	mov    -0xc(%ebp),%edx
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	01 d0                	add    %edx,%eax
 27b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    

00000283 <stat>:

int
stat(char *n, struct stat *st)
{
 283:	55                   	push   %ebp
 284:	89 e5                	mov    %esp,%ebp
 286:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	6a 00                	push   $0x0
 28e:	ff 75 08             	pushl  0x8(%ebp)
 291:	e8 0c 01 00 00       	call   3a2 <open>
 296:	83 c4 10             	add    $0x10,%esp
 299:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 29c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a0:	79 07                	jns    2a9 <stat+0x26>
    return -1;
 2a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a7:	eb 25                	jmp    2ce <stat+0x4b>
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	pushl  0xc(%ebp)
 2af:	ff 75 f4             	pushl  -0xc(%ebp)
 2b2:	e8 03 01 00 00       	call   3ba <fstat>
 2b7:	83 c4 10             	add    $0x10,%esp
 2ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2bd:	83 ec 0c             	sub    $0xc,%esp
 2c0:	ff 75 f4             	pushl  -0xc(%ebp)
 2c3:	e8 c2 00 00 00       	call   38a <close>
 2c8:	83 c4 10             	add    $0x10,%esp
  return r;
 2cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ce:	c9                   	leave  
 2cf:	c3                   	ret    

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2dd:	eb 25                	jmp    304 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2df:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e2:	89 d0                	mov    %edx,%eax
 2e4:	c1 e0 02             	shl    $0x2,%eax
 2e7:	01 d0                	add    %edx,%eax
 2e9:	01 c0                	add    %eax,%eax
 2eb:	89 c1                	mov    %eax,%ecx
 2ed:	8b 45 08             	mov    0x8(%ebp),%eax
 2f0:	8d 50 01             	lea    0x1(%eax),%edx
 2f3:	89 55 08             	mov    %edx,0x8(%ebp)
 2f6:	0f b6 00             	movzbl (%eax),%eax
 2f9:	0f be c0             	movsbl %al,%eax
 2fc:	01 c8                	add    %ecx,%eax
 2fe:	83 e8 30             	sub    $0x30,%eax
 301:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	0f b6 00             	movzbl (%eax),%eax
 30a:	3c 2f                	cmp    $0x2f,%al
 30c:	7e 0a                	jle    318 <atoi+0x48>
 30e:	8b 45 08             	mov    0x8(%ebp),%eax
 311:	0f b6 00             	movzbl (%eax),%eax
 314:	3c 39                	cmp    $0x39,%al
 316:	7e c7                	jle    2df <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 318:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 31b:	c9                   	leave  
 31c:	c3                   	ret    

0000031d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 31d:	55                   	push   %ebp
 31e:	89 e5                	mov    %esp,%ebp
 320:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 329:	8b 45 0c             	mov    0xc(%ebp),%eax
 32c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 32f:	eb 17                	jmp    348 <memmove+0x2b>
    *dst++ = *src++;
 331:	8b 45 fc             	mov    -0x4(%ebp),%eax
 334:	8d 50 01             	lea    0x1(%eax),%edx
 337:	89 55 fc             	mov    %edx,-0x4(%ebp)
 33a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 33d:	8d 4a 01             	lea    0x1(%edx),%ecx
 340:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 343:	0f b6 12             	movzbl (%edx),%edx
 346:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 348:	8b 45 10             	mov    0x10(%ebp),%eax
 34b:	8d 50 ff             	lea    -0x1(%eax),%edx
 34e:	89 55 10             	mov    %edx,0x10(%ebp)
 351:	85 c0                	test   %eax,%eax
 353:	7f dc                	jg     331 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 355:	8b 45 08             	mov    0x8(%ebp),%eax
}
 358:	c9                   	leave  
 359:	c3                   	ret    

0000035a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35a:	b8 01 00 00 00       	mov    $0x1,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <exit>:
SYSCALL(exit)
 362:	b8 02 00 00 00       	mov    $0x2,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <wait>:
SYSCALL(wait)
 36a:	b8 03 00 00 00       	mov    $0x3,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <pipe>:
SYSCALL(pipe)
 372:	b8 04 00 00 00       	mov    $0x4,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <read>:
SYSCALL(read)
 37a:	b8 05 00 00 00       	mov    $0x5,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <write>:
SYSCALL(write)
 382:	b8 10 00 00 00       	mov    $0x10,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <close>:
SYSCALL(close)
 38a:	b8 15 00 00 00       	mov    $0x15,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <kill>:
SYSCALL(kill)
 392:	b8 06 00 00 00       	mov    $0x6,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <exec>:
SYSCALL(exec)
 39a:	b8 07 00 00 00       	mov    $0x7,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <open>:
SYSCALL(open)
 3a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mknod>:
SYSCALL(mknod)
 3aa:	b8 11 00 00 00       	mov    $0x11,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <unlink>:
SYSCALL(unlink)
 3b2:	b8 12 00 00 00       	mov    $0x12,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <fstat>:
SYSCALL(fstat)
 3ba:	b8 08 00 00 00       	mov    $0x8,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <link>:
SYSCALL(link)
 3c2:	b8 13 00 00 00       	mov    $0x13,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <mkdir>:
SYSCALL(mkdir)
 3ca:	b8 14 00 00 00       	mov    $0x14,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <chdir>:
SYSCALL(chdir)
 3d2:	b8 09 00 00 00       	mov    $0x9,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <dup>:
SYSCALL(dup)
 3da:	b8 0a 00 00 00       	mov    $0xa,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <getpid>:
SYSCALL(getpid)
 3e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <sbrk>:
SYSCALL(sbrk)
 3ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <sleep>:
SYSCALL(sleep)
 3f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <uptime>:
SYSCALL(uptime)
 3fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 402:	55                   	push   %ebp
 403:	89 e5                	mov    %esp,%ebp
 405:	83 ec 18             	sub    $0x18,%esp
 408:	8b 45 0c             	mov    0xc(%ebp),%eax
 40b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 40e:	83 ec 04             	sub    $0x4,%esp
 411:	6a 01                	push   $0x1
 413:	8d 45 f4             	lea    -0xc(%ebp),%eax
 416:	50                   	push   %eax
 417:	ff 75 08             	pushl  0x8(%ebp)
 41a:	e8 63 ff ff ff       	call   382 <write>
 41f:	83 c4 10             	add    $0x10,%esp
}
 422:	90                   	nop
 423:	c9                   	leave  
 424:	c3                   	ret    

00000425 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 425:	55                   	push   %ebp
 426:	89 e5                	mov    %esp,%ebp
 428:	53                   	push   %ebx
 429:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 42c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 433:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 437:	74 17                	je     450 <printint+0x2b>
 439:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 43d:	79 11                	jns    450 <printint+0x2b>
    neg = 1;
 43f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 446:	8b 45 0c             	mov    0xc(%ebp),%eax
 449:	f7 d8                	neg    %eax
 44b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 44e:	eb 06                	jmp    456 <printint+0x31>
  } else {
    x = xx;
 450:	8b 45 0c             	mov    0xc(%ebp),%eax
 453:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 456:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 45d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 460:	8d 41 01             	lea    0x1(%ecx),%eax
 463:	89 45 f4             	mov    %eax,-0xc(%ebp)
 466:	8b 5d 10             	mov    0x10(%ebp),%ebx
 469:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46c:	ba 00 00 00 00       	mov    $0x0,%edx
 471:	f7 f3                	div    %ebx
 473:	89 d0                	mov    %edx,%eax
 475:	0f b6 80 30 0b 00 00 	movzbl 0xb30(%eax),%eax
 47c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 480:	8b 5d 10             	mov    0x10(%ebp),%ebx
 483:	8b 45 ec             	mov    -0x14(%ebp),%eax
 486:	ba 00 00 00 00       	mov    $0x0,%edx
 48b:	f7 f3                	div    %ebx
 48d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 490:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 494:	75 c7                	jne    45d <printint+0x38>
  if(neg)
 496:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49a:	74 2d                	je     4c9 <printint+0xa4>
    buf[i++] = '-';
 49c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49f:	8d 50 01             	lea    0x1(%eax),%edx
 4a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4aa:	eb 1d                	jmp    4c9 <printint+0xa4>
    putc(fd, buf[i]);
 4ac:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b2:	01 d0                	add    %edx,%eax
 4b4:	0f b6 00             	movzbl (%eax),%eax
 4b7:	0f be c0             	movsbl %al,%eax
 4ba:	83 ec 08             	sub    $0x8,%esp
 4bd:	50                   	push   %eax
 4be:	ff 75 08             	pushl  0x8(%ebp)
 4c1:	e8 3c ff ff ff       	call   402 <putc>
 4c6:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4c9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d1:	79 d9                	jns    4ac <printint+0x87>
    putc(fd, buf[i]);
}
 4d3:	90                   	nop
 4d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4d7:	c9                   	leave  
 4d8:	c3                   	ret    

000004d9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d9:	55                   	push   %ebp
 4da:	89 e5                	mov    %esp,%ebp
 4dc:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4e6:	8d 45 0c             	lea    0xc(%ebp),%eax
 4e9:	83 c0 04             	add    $0x4,%eax
 4ec:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4f6:	e9 59 01 00 00       	jmp    654 <printf+0x17b>
    c = fmt[i] & 0xff;
 4fb:	8b 55 0c             	mov    0xc(%ebp),%edx
 4fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 501:	01 d0                	add    %edx,%eax
 503:	0f b6 00             	movzbl (%eax),%eax
 506:	0f be c0             	movsbl %al,%eax
 509:	25 ff 00 00 00       	and    $0xff,%eax
 50e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 511:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 515:	75 2c                	jne    543 <printf+0x6a>
      if(c == '%'){
 517:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 51b:	75 0c                	jne    529 <printf+0x50>
        state = '%';
 51d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 524:	e9 27 01 00 00       	jmp    650 <printf+0x177>
      } else {
        putc(fd, c);
 529:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 52c:	0f be c0             	movsbl %al,%eax
 52f:	83 ec 08             	sub    $0x8,%esp
 532:	50                   	push   %eax
 533:	ff 75 08             	pushl  0x8(%ebp)
 536:	e8 c7 fe ff ff       	call   402 <putc>
 53b:	83 c4 10             	add    $0x10,%esp
 53e:	e9 0d 01 00 00       	jmp    650 <printf+0x177>
      }
    } else if(state == '%'){
 543:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 547:	0f 85 03 01 00 00    	jne    650 <printf+0x177>
      if(c == 'd'){
 54d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 551:	75 1e                	jne    571 <printf+0x98>
        printint(fd, *ap, 10, 1);
 553:	8b 45 e8             	mov    -0x18(%ebp),%eax
 556:	8b 00                	mov    (%eax),%eax
 558:	6a 01                	push   $0x1
 55a:	6a 0a                	push   $0xa
 55c:	50                   	push   %eax
 55d:	ff 75 08             	pushl  0x8(%ebp)
 560:	e8 c0 fe ff ff       	call   425 <printint>
 565:	83 c4 10             	add    $0x10,%esp
        ap++;
 568:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56c:	e9 d8 00 00 00       	jmp    649 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 571:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 575:	74 06                	je     57d <printf+0xa4>
 577:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 57b:	75 1e                	jne    59b <printf+0xc2>
        printint(fd, *ap, 16, 0);
 57d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 580:	8b 00                	mov    (%eax),%eax
 582:	6a 00                	push   $0x0
 584:	6a 10                	push   $0x10
 586:	50                   	push   %eax
 587:	ff 75 08             	pushl  0x8(%ebp)
 58a:	e8 96 fe ff ff       	call   425 <printint>
 58f:	83 c4 10             	add    $0x10,%esp
        ap++;
 592:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 596:	e9 ae 00 00 00       	jmp    649 <printf+0x170>
      } else if(c == 's'){
 59b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 59f:	75 43                	jne    5e4 <printf+0x10b>
        s = (char*)*ap;
 5a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a4:	8b 00                	mov    (%eax),%eax
 5a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b1:	75 25                	jne    5d8 <printf+0xff>
          s = "(null)";
 5b3:	c7 45 f4 bd 08 00 00 	movl   $0x8bd,-0xc(%ebp)
        while(*s != 0){
 5ba:	eb 1c                	jmp    5d8 <printf+0xff>
          putc(fd, *s);
 5bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bf:	0f b6 00             	movzbl (%eax),%eax
 5c2:	0f be c0             	movsbl %al,%eax
 5c5:	83 ec 08             	sub    $0x8,%esp
 5c8:	50                   	push   %eax
 5c9:	ff 75 08             	pushl  0x8(%ebp)
 5cc:	e8 31 fe ff ff       	call   402 <putc>
 5d1:	83 c4 10             	add    $0x10,%esp
          s++;
 5d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5db:	0f b6 00             	movzbl (%eax),%eax
 5de:	84 c0                	test   %al,%al
 5e0:	75 da                	jne    5bc <printf+0xe3>
 5e2:	eb 65                	jmp    649 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5e4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5e8:	75 1d                	jne    607 <printf+0x12e>
        putc(fd, *ap);
 5ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ed:	8b 00                	mov    (%eax),%eax
 5ef:	0f be c0             	movsbl %al,%eax
 5f2:	83 ec 08             	sub    $0x8,%esp
 5f5:	50                   	push   %eax
 5f6:	ff 75 08             	pushl  0x8(%ebp)
 5f9:	e8 04 fe ff ff       	call   402 <putc>
 5fe:	83 c4 10             	add    $0x10,%esp
        ap++;
 601:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 605:	eb 42                	jmp    649 <printf+0x170>
      } else if(c == '%'){
 607:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 60b:	75 17                	jne    624 <printf+0x14b>
        putc(fd, c);
 60d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 610:	0f be c0             	movsbl %al,%eax
 613:	83 ec 08             	sub    $0x8,%esp
 616:	50                   	push   %eax
 617:	ff 75 08             	pushl  0x8(%ebp)
 61a:	e8 e3 fd ff ff       	call   402 <putc>
 61f:	83 c4 10             	add    $0x10,%esp
 622:	eb 25                	jmp    649 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 624:	83 ec 08             	sub    $0x8,%esp
 627:	6a 25                	push   $0x25
 629:	ff 75 08             	pushl  0x8(%ebp)
 62c:	e8 d1 fd ff ff       	call   402 <putc>
 631:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 634:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 637:	0f be c0             	movsbl %al,%eax
 63a:	83 ec 08             	sub    $0x8,%esp
 63d:	50                   	push   %eax
 63e:	ff 75 08             	pushl  0x8(%ebp)
 641:	e8 bc fd ff ff       	call   402 <putc>
 646:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 649:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 650:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 654:	8b 55 0c             	mov    0xc(%ebp),%edx
 657:	8b 45 f0             	mov    -0x10(%ebp),%eax
 65a:	01 d0                	add    %edx,%eax
 65c:	0f b6 00             	movzbl (%eax),%eax
 65f:	84 c0                	test   %al,%al
 661:	0f 85 94 fe ff ff    	jne    4fb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 667:	90                   	nop
 668:	c9                   	leave  
 669:	c3                   	ret    

0000066a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 66a:	55                   	push   %ebp
 66b:	89 e5                	mov    %esp,%ebp
 66d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 670:	8b 45 08             	mov    0x8(%ebp),%eax
 673:	83 e8 08             	sub    $0x8,%eax
 676:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 679:	a1 68 0b 00 00       	mov    0xb68,%eax
 67e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 681:	eb 24                	jmp    6a7 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68b:	77 12                	ja     69f <free+0x35>
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 693:	77 24                	ja     6b9 <free+0x4f>
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	8b 00                	mov    (%eax),%eax
 69a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69d:	77 1a                	ja     6b9 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	8b 00                	mov    (%eax),%eax
 6a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ad:	76 d4                	jbe    683 <free+0x19>
 6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b2:	8b 00                	mov    (%eax),%eax
 6b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b7:	76 ca                	jbe    683 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bc:	8b 40 04             	mov    0x4(%eax),%eax
 6bf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c9:	01 c2                	add    %eax,%edx
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	8b 00                	mov    (%eax),%eax
 6d0:	39 c2                	cmp    %eax,%edx
 6d2:	75 24                	jne    6f8 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d7:	8b 50 04             	mov    0x4(%eax),%edx
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	8b 00                	mov    (%eax),%eax
 6df:	8b 40 04             	mov    0x4(%eax),%eax
 6e2:	01 c2                	add    %eax,%edx
 6e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e7:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ed:	8b 00                	mov    (%eax),%eax
 6ef:	8b 10                	mov    (%eax),%edx
 6f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f4:	89 10                	mov    %edx,(%eax)
 6f6:	eb 0a                	jmp    702 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fb:	8b 10                	mov    (%eax),%edx
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 40 04             	mov    0x4(%eax),%eax
 708:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 70f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 712:	01 d0                	add    %edx,%eax
 714:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 717:	75 20                	jne    739 <free+0xcf>
    p->s.size += bp->s.size;
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	8b 50 04             	mov    0x4(%eax),%edx
 71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 722:	8b 40 04             	mov    0x4(%eax),%eax
 725:	01 c2                	add    %eax,%edx
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 72d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 730:	8b 10                	mov    (%eax),%edx
 732:	8b 45 fc             	mov    -0x4(%ebp),%eax
 735:	89 10                	mov    %edx,(%eax)
 737:	eb 08                	jmp    741 <free+0xd7>
  } else
    p->s.ptr = bp;
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 73f:	89 10                	mov    %edx,(%eax)
  freep = p;
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	a3 68 0b 00 00       	mov    %eax,0xb68
}
 749:	90                   	nop
 74a:	c9                   	leave  
 74b:	c3                   	ret    

0000074c <morecore>:

static Header*
morecore(uint nu)
{
 74c:	55                   	push   %ebp
 74d:	89 e5                	mov    %esp,%ebp
 74f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 752:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 759:	77 07                	ja     762 <morecore+0x16>
    nu = 4096;
 75b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 762:	8b 45 08             	mov    0x8(%ebp),%eax
 765:	c1 e0 03             	shl    $0x3,%eax
 768:	83 ec 0c             	sub    $0xc,%esp
 76b:	50                   	push   %eax
 76c:	e8 79 fc ff ff       	call   3ea <sbrk>
 771:	83 c4 10             	add    $0x10,%esp
 774:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 777:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 77b:	75 07                	jne    784 <morecore+0x38>
    return 0;
 77d:	b8 00 00 00 00       	mov    $0x0,%eax
 782:	eb 26                	jmp    7aa <morecore+0x5e>
  hp = (Header*)p;
 784:	8b 45 f4             	mov    -0xc(%ebp),%eax
 787:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	8b 55 08             	mov    0x8(%ebp),%edx
 790:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 793:	8b 45 f0             	mov    -0x10(%ebp),%eax
 796:	83 c0 08             	add    $0x8,%eax
 799:	83 ec 0c             	sub    $0xc,%esp
 79c:	50                   	push   %eax
 79d:	e8 c8 fe ff ff       	call   66a <free>
 7a2:	83 c4 10             	add    $0x10,%esp
  return freep;
 7a5:	a1 68 0b 00 00       	mov    0xb68,%eax
}
 7aa:	c9                   	leave  
 7ab:	c3                   	ret    

000007ac <malloc>:

void*
malloc(uint nbytes)
{
 7ac:	55                   	push   %ebp
 7ad:	89 e5                	mov    %esp,%ebp
 7af:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b2:	8b 45 08             	mov    0x8(%ebp),%eax
 7b5:	83 c0 07             	add    $0x7,%eax
 7b8:	c1 e8 03             	shr    $0x3,%eax
 7bb:	83 c0 01             	add    $0x1,%eax
 7be:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7c1:	a1 68 0b 00 00       	mov    0xb68,%eax
 7c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7cd:	75 23                	jne    7f2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7cf:	c7 45 f0 60 0b 00 00 	movl   $0xb60,-0x10(%ebp)
 7d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d9:	a3 68 0b 00 00       	mov    %eax,0xb68
 7de:	a1 68 0b 00 00       	mov    0xb68,%eax
 7e3:	a3 60 0b 00 00       	mov    %eax,0xb60
    base.s.size = 0;
 7e8:	c7 05 64 0b 00 00 00 	movl   $0x0,0xb64
 7ef:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f5:	8b 00                	mov    (%eax),%eax
 7f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fd:	8b 40 04             	mov    0x4(%eax),%eax
 800:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 803:	72 4d                	jb     852 <malloc+0xa6>
      if(p->s.size == nunits)
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	8b 40 04             	mov    0x4(%eax),%eax
 80b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 80e:	75 0c                	jne    81c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	8b 10                	mov    (%eax),%edx
 815:	8b 45 f0             	mov    -0x10(%ebp),%eax
 818:	89 10                	mov    %edx,(%eax)
 81a:	eb 26                	jmp    842 <malloc+0x96>
      else {
        p->s.size -= nunits;
 81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81f:	8b 40 04             	mov    0x4(%eax),%eax
 822:	2b 45 ec             	sub    -0x14(%ebp),%eax
 825:	89 c2                	mov    %eax,%edx
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 830:	8b 40 04             	mov    0x4(%eax),%eax
 833:	c1 e0 03             	shl    $0x3,%eax
 836:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 839:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 83f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 842:	8b 45 f0             	mov    -0x10(%ebp),%eax
 845:	a3 68 0b 00 00       	mov    %eax,0xb68
      return (void*)(p + 1);
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	83 c0 08             	add    $0x8,%eax
 850:	eb 3b                	jmp    88d <malloc+0xe1>
    }
    if(p == freep)
 852:	a1 68 0b 00 00       	mov    0xb68,%eax
 857:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 85a:	75 1e                	jne    87a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 85c:	83 ec 0c             	sub    $0xc,%esp
 85f:	ff 75 ec             	pushl  -0x14(%ebp)
 862:	e8 e5 fe ff ff       	call   74c <morecore>
 867:	83 c4 10             	add    $0x10,%esp
 86a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 86d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 871:	75 07                	jne    87a <malloc+0xce>
        return 0;
 873:	b8 00 00 00 00       	mov    $0x0,%eax
 878:	eb 13                	jmp    88d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 880:	8b 45 f4             	mov    -0xc(%ebp),%eax
 883:	8b 00                	mov    (%eax),%eax
 885:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 888:	e9 6d ff ff ff       	jmp    7fa <malloc+0x4e>
}
 88d:	c9                   	leave  
 88e:	c3                   	ret    
