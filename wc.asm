
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 69                	jmp    8b <wc+0x8b>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 58                	jmp    83 <wc+0x83>
      c++;
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 20 0e 00 00       	add    $0xe20,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 20 0e 00 00       	add    $0xe20,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	83 ec 08             	sub    $0x8,%esp
  53:	50                   	push   %eax
  54:	68 dc 0a 00 00       	push   $0xadc
  59:	e8 35 02 00 00       	call   293 <strchr>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	85 c0                	test   %eax,%eax
  63:	74 09                	je     6e <wc+0x6e>
        inword = 0;
  65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6c:	eb 11                	jmp    7f <wc+0x7f>
      else if(!inword){
  6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  72:	75 0b                	jne    7f <wc+0x7f>
        w++;
  74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  89:	7c a0                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8b:	83 ec 04             	sub    $0x4,%esp
  8e:	68 00 02 00 00       	push   $0x200
  93:	68 20 0e 00 00       	push   $0xe20
  98:	ff 75 08             	pushl  0x8(%ebp)
  9b:	e8 26 05 00 00       	call   5c6 <read>
  a0:	83 c4 10             	add    $0x10,%esp
  a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b4:	79 17                	jns    cd <wc+0xcd>
    printf(1, "wc: read error\n");
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 e2 0a 00 00       	push   $0xae2
  be:	6a 01                	push   $0x1
  c0:	e8 60 06 00 00       	call   725 <printf>
  c5:	83 c4 10             	add    $0x10,%esp
    exit();
  c8:	e8 e1 04 00 00       	call   5ae <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	ff 75 0c             	pushl  0xc(%ebp)
  d3:	ff 75 e8             	pushl  -0x18(%ebp)
  d6:	ff 75 ec             	pushl  -0x14(%ebp)
  d9:	ff 75 f0             	pushl  -0x10(%ebp)
  dc:	68 f2 0a 00 00       	push   $0xaf2
  e1:	6a 01                	push   $0x1
  e3:	e8 3d 06 00 00       	call   725 <printf>
  e8:	83 c4 20             	add    $0x20,%esp
}
  eb:	90                   	nop
  ec:	c9                   	leave  
  ed:	c3                   	ret    

000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f2:	83 e4 f0             	and    $0xfffffff0,%esp
  f5:	ff 71 fc             	pushl  -0x4(%ecx)
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	53                   	push   %ebx
  fc:	51                   	push   %ecx
  fd:	83 ec 10             	sub    $0x10,%esp
 100:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
 102:	83 3b 01             	cmpl   $0x1,(%ebx)
 105:	7f 17                	jg     11e <main+0x30>
    wc(0, "");
 107:	83 ec 08             	sub    $0x8,%esp
 10a:	68 ff 0a 00 00       	push   $0xaff
 10f:	6a 00                	push   $0x0
 111:	e8 ea fe ff ff       	call   0 <wc>
 116:	83 c4 10             	add    $0x10,%esp
    exit();
 119:	e8 90 04 00 00       	call   5ae <exit>
  }

  for(i = 1; i < argc; i++){
 11e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 125:	e9 83 00 00 00       	jmp    1ad <main+0xbf>
    if((fd = open(argv[i], 0)) < 0){
 12a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 12d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 134:	8b 43 04             	mov    0x4(%ebx),%eax
 137:	01 d0                	add    %edx,%eax
 139:	8b 00                	mov    (%eax),%eax
 13b:	83 ec 08             	sub    $0x8,%esp
 13e:	6a 00                	push   $0x0
 140:	50                   	push   %eax
 141:	e8 a8 04 00 00       	call   5ee <open>
 146:	83 c4 10             	add    $0x10,%esp
 149:	89 45 f0             	mov    %eax,-0x10(%ebp)
 14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 150:	79 29                	jns    17b <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
 152:	8b 45 f4             	mov    -0xc(%ebp),%eax
 155:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15c:	8b 43 04             	mov    0x4(%ebx),%eax
 15f:	01 d0                	add    %edx,%eax
 161:	8b 00                	mov    (%eax),%eax
 163:	83 ec 04             	sub    $0x4,%esp
 166:	50                   	push   %eax
 167:	68 00 0b 00 00       	push   $0xb00
 16c:	6a 01                	push   $0x1
 16e:	e8 b2 05 00 00       	call   725 <printf>
 173:	83 c4 10             	add    $0x10,%esp
      exit();
 176:	e8 33 04 00 00       	call   5ae <exit>
    }
    wc(fd, argv[i]);
 17b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 185:	8b 43 04             	mov    0x4(%ebx),%eax
 188:	01 d0                	add    %edx,%eax
 18a:	8b 00                	mov    (%eax),%eax
 18c:	83 ec 08             	sub    $0x8,%esp
 18f:	50                   	push   %eax
 190:	ff 75 f0             	pushl  -0x10(%ebp)
 193:	e8 68 fe ff ff       	call   0 <wc>
 198:	83 c4 10             	add    $0x10,%esp
    close(fd);
 19b:	83 ec 0c             	sub    $0xc,%esp
 19e:	ff 75 f0             	pushl  -0x10(%ebp)
 1a1:	e8 30 04 00 00       	call   5d6 <close>
 1a6:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b0:	3b 03                	cmp    (%ebx),%eax
 1b2:	0f 8c 72 ff ff ff    	jl     12a <main+0x3c>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1b8:	e8 f1 03 00 00       	call   5ae <exit>

000001bd <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	57                   	push   %edi
 1c1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c5:	8b 55 10             	mov    0x10(%ebp),%edx
 1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cb:	89 cb                	mov    %ecx,%ebx
 1cd:	89 df                	mov    %ebx,%edi
 1cf:	89 d1                	mov    %edx,%ecx
 1d1:	fc                   	cld    
 1d2:	f3 aa                	rep stos %al,%es:(%edi)
 1d4:	89 ca                	mov    %ecx,%edx
 1d6:	89 fb                	mov    %edi,%ebx
 1d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1db:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1de:	90                   	nop
 1df:	5b                   	pop    %ebx
 1e0:	5f                   	pop    %edi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    

000001e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1ef:	90                   	nop
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	8d 50 01             	lea    0x1(%eax),%edx
 1f6:	89 55 08             	mov    %edx,0x8(%ebp)
 1f9:	8b 55 0c             	mov    0xc(%ebp),%edx
 1fc:	8d 4a 01             	lea    0x1(%edx),%ecx
 1ff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 202:	0f b6 12             	movzbl (%edx),%edx
 205:	88 10                	mov    %dl,(%eax)
 207:	0f b6 00             	movzbl (%eax),%eax
 20a:	84 c0                	test   %al,%al
 20c:	75 e2                	jne    1f0 <strcpy+0xd>
    ;
  return os;
 20e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 211:	c9                   	leave  
 212:	c3                   	ret    

00000213 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 213:	55                   	push   %ebp
 214:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 216:	eb 08                	jmp    220 <strcmp+0xd>
    p++, q++;
 218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 220:	8b 45 08             	mov    0x8(%ebp),%eax
 223:	0f b6 00             	movzbl (%eax),%eax
 226:	84 c0                	test   %al,%al
 228:	74 10                	je     23a <strcmp+0x27>
 22a:	8b 45 08             	mov    0x8(%ebp),%eax
 22d:	0f b6 10             	movzbl (%eax),%edx
 230:	8b 45 0c             	mov    0xc(%ebp),%eax
 233:	0f b6 00             	movzbl (%eax),%eax
 236:	38 c2                	cmp    %al,%dl
 238:	74 de                	je     218 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
 23d:	0f b6 00             	movzbl (%eax),%eax
 240:	0f b6 d0             	movzbl %al,%edx
 243:	8b 45 0c             	mov    0xc(%ebp),%eax
 246:	0f b6 00             	movzbl (%eax),%eax
 249:	0f b6 c0             	movzbl %al,%eax
 24c:	29 c2                	sub    %eax,%edx
 24e:	89 d0                	mov    %edx,%eax
}
 250:	5d                   	pop    %ebp
 251:	c3                   	ret    

00000252 <strlen>:

uint
strlen(char *s)
{
 252:	55                   	push   %ebp
 253:	89 e5                	mov    %esp,%ebp
 255:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 25f:	eb 04                	jmp    265 <strlen+0x13>
 261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 265:	8b 55 fc             	mov    -0x4(%ebp),%edx
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	01 d0                	add    %edx,%eax
 26d:	0f b6 00             	movzbl (%eax),%eax
 270:	84 c0                	test   %al,%al
 272:	75 ed                	jne    261 <strlen+0xf>
    ;
  return n;
 274:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 277:	c9                   	leave  
 278:	c3                   	ret    

00000279 <memset>:

void*
memset(void *dst, int c, uint n)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 27c:	8b 45 10             	mov    0x10(%ebp),%eax
 27f:	50                   	push   %eax
 280:	ff 75 0c             	pushl  0xc(%ebp)
 283:	ff 75 08             	pushl  0x8(%ebp)
 286:	e8 32 ff ff ff       	call   1bd <stosb>
 28b:	83 c4 0c             	add    $0xc,%esp
  return dst;
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 291:	c9                   	leave  
 292:	c3                   	ret    

00000293 <strchr>:

char*
strchr(const char *s, char c)
{
 293:	55                   	push   %ebp
 294:	89 e5                	mov    %esp,%ebp
 296:	83 ec 04             	sub    $0x4,%esp
 299:	8b 45 0c             	mov    0xc(%ebp),%eax
 29c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 29f:	eb 14                	jmp    2b5 <strchr+0x22>
    if(*s == c)
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	0f b6 00             	movzbl (%eax),%eax
 2a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2aa:	75 05                	jne    2b1 <strchr+0x1e>
      return (char*)s;
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
 2af:	eb 13                	jmp    2c4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	84 c0                	test   %al,%al
 2bd:	75 e2                	jne    2a1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <gets>:

char*
gets(char *buf, int max)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d3:	eb 42                	jmp    317 <gets+0x51>
    cc = read(0, &c, 1);
 2d5:	83 ec 04             	sub    $0x4,%esp
 2d8:	6a 01                	push   $0x1
 2da:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2dd:	50                   	push   %eax
 2de:	6a 00                	push   $0x0
 2e0:	e8 e1 02 00 00       	call   5c6 <read>
 2e5:	83 c4 10             	add    $0x10,%esp
 2e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2ef:	7e 33                	jle    324 <gets+0x5e>
      break;
    buf[i++] = c;
 2f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f4:	8d 50 01             	lea    0x1(%eax),%edx
 2f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2fa:	89 c2                	mov    %eax,%edx
 2fc:	8b 45 08             	mov    0x8(%ebp),%eax
 2ff:	01 c2                	add    %eax,%edx
 301:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 305:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 307:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30b:	3c 0a                	cmp    $0xa,%al
 30d:	74 16                	je     325 <gets+0x5f>
 30f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 313:	3c 0d                	cmp    $0xd,%al
 315:	74 0e                	je     325 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 317:	8b 45 f4             	mov    -0xc(%ebp),%eax
 31a:	83 c0 01             	add    $0x1,%eax
 31d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 320:	7c b3                	jl     2d5 <gets+0xf>
 322:	eb 01                	jmp    325 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 324:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 325:	8b 55 f4             	mov    -0xc(%ebp),%edx
 328:	8b 45 08             	mov    0x8(%ebp),%eax
 32b:	01 d0                	add    %edx,%eax
 32d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 330:	8b 45 08             	mov    0x8(%ebp),%eax
}
 333:	c9                   	leave  
 334:	c3                   	ret    

00000335 <stat>:

int
stat(char *n, struct stat *st)
{
 335:	55                   	push   %ebp
 336:	89 e5                	mov    %esp,%ebp
 338:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33b:	83 ec 08             	sub    $0x8,%esp
 33e:	6a 00                	push   $0x0
 340:	ff 75 08             	pushl  0x8(%ebp)
 343:	e8 a6 02 00 00       	call   5ee <open>
 348:	83 c4 10             	add    $0x10,%esp
 34b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 34e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 352:	79 07                	jns    35b <stat+0x26>
    return -1;
 354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 359:	eb 25                	jmp    380 <stat+0x4b>
  r = fstat(fd, st);
 35b:	83 ec 08             	sub    $0x8,%esp
 35e:	ff 75 0c             	pushl  0xc(%ebp)
 361:	ff 75 f4             	pushl  -0xc(%ebp)
 364:	e8 9d 02 00 00       	call   606 <fstat>
 369:	83 c4 10             	add    $0x10,%esp
 36c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 36f:	83 ec 0c             	sub    $0xc,%esp
 372:	ff 75 f4             	pushl  -0xc(%ebp)
 375:	e8 5c 02 00 00       	call   5d6 <close>
 37a:	83 c4 10             	add    $0x10,%esp
  return r;
 37d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 380:	c9                   	leave  
 381:	c3                   	ret    

00000382 <atoi>:

int
atoi(const char *s)
{
 382:	55                   	push   %ebp
 383:	89 e5                	mov    %esp,%ebp
 385:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 38f:	eb 25                	jmp    3b6 <atoi+0x34>
    n = n*10 + *s++ - '0';
 391:	8b 55 fc             	mov    -0x4(%ebp),%edx
 394:	89 d0                	mov    %edx,%eax
 396:	c1 e0 02             	shl    $0x2,%eax
 399:	01 d0                	add    %edx,%eax
 39b:	01 c0                	add    %eax,%eax
 39d:	89 c1                	mov    %eax,%ecx
 39f:	8b 45 08             	mov    0x8(%ebp),%eax
 3a2:	8d 50 01             	lea    0x1(%eax),%edx
 3a5:	89 55 08             	mov    %edx,0x8(%ebp)
 3a8:	0f b6 00             	movzbl (%eax),%eax
 3ab:	0f be c0             	movsbl %al,%eax
 3ae:	01 c8                	add    %ecx,%eax
 3b0:	83 e8 30             	sub    $0x30,%eax
 3b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b6:	8b 45 08             	mov    0x8(%ebp),%eax
 3b9:	0f b6 00             	movzbl (%eax),%eax
 3bc:	3c 2f                	cmp    $0x2f,%al
 3be:	7e 0a                	jle    3ca <atoi+0x48>
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
 3c3:	0f b6 00             	movzbl (%eax),%eax
 3c6:	3c 39                	cmp    $0x39,%al
 3c8:	7e c7                	jle    391 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3cd:	c9                   	leave  
 3ce:	c3                   	ret    

000003cf <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3cf:	55                   	push   %ebp
 3d0:	89 e5                	mov    %esp,%ebp
 3d2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3d5:	8b 45 08             	mov    0x8(%ebp),%eax
 3d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3db:	8b 45 0c             	mov    0xc(%ebp),%eax
 3de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e1:	eb 17                	jmp    3fa <memmove+0x2b>
    *dst++ = *src++;
 3e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3e6:	8d 50 01             	lea    0x1(%eax),%edx
 3e9:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3ef:	8d 4a 01             	lea    0x1(%edx),%ecx
 3f2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3f5:	0f b6 12             	movzbl (%edx),%edx
 3f8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3fa:	8b 45 10             	mov    0x10(%ebp),%eax
 3fd:	8d 50 ff             	lea    -0x1(%eax),%edx
 400:	89 55 10             	mov    %edx,0x10(%ebp)
 403:	85 c0                	test   %eax,%eax
 405:	7f dc                	jg     3e3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 407:	8b 45 08             	mov    0x8(%ebp),%eax
}
 40a:	c9                   	leave  
 40b:	c3                   	ret    

0000040c <historyAdd>:

void
historyAdd(char *buf1){
 40c:	55                   	push   %ebp
 40d:	89 e5                	mov    %esp,%ebp
 40f:	53                   	push   %ebx
 410:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 416:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 41d:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 424:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 42a:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 42e:	83 ec 08             	sub    $0x8,%esp
 431:	6a 00                	push   $0x0
 433:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 436:	50                   	push   %eax
 437:	e8 b2 01 00 00       	call   5ee <open>
 43c:	83 c4 10             	add    $0x10,%esp
 43f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 442:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 446:	79 1b                	jns    463 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 448:	83 ec 04             	sub    $0x4,%esp
 44b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 44e:	50                   	push   %eax
 44f:	68 14 0b 00 00       	push   $0xb14
 454:	6a 01                	push   $0x1
 456:	e8 ca 02 00 00       	call   725 <printf>
 45b:	83 c4 10             	add    $0x10,%esp
       exit();
 45e:	e8 4b 01 00 00       	call   5ae <exit>
     }

     int i=0;
 463:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 46a:	eb 1c                	jmp    488 <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 46c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 46f:	8b 45 08             	mov    0x8(%ebp),%eax
 472:	01 d0                	add    %edx,%eax
 474:	0f b6 00             	movzbl (%eax),%eax
 477:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 47d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 480:	01 ca                	add    %ecx,%edx
 482:	88 02                	mov    %al,(%edx)
	i++;
 484:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 488:	8b 55 f4             	mov    -0xc(%ebp),%edx
 48b:	8b 45 08             	mov    0x8(%ebp),%eax
 48e:	01 d0                	add    %edx,%eax
 490:	0f b6 00             	movzbl (%eax),%eax
 493:	84 c0                	test   %al,%al
 495:	75 d5                	jne    46c <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 497:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 49d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a0:	01 d0                	add    %edx,%eax
 4a2:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 4a5:	eb 5a                	jmp    501 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 4a7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 4aa:	83 ec 0c             	sub    $0xc,%esp
 4ad:	ff 75 08             	pushl  0x8(%ebp)
 4b0:	e8 9d fd ff ff       	call   252 <strlen>
 4b5:	83 c4 10             	add    $0x10,%esp
 4b8:	29 c3                	sub    %eax,%ebx
 4ba:	89 d8                	mov    %ebx,%eax
 4bc:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 4c3:	ff 
 4c4:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 4ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4cd:	01 ca                	add    %ecx,%edx
 4cf:	88 02                	mov    %al,(%edx)
		i++;
 4d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 4d5:	83 ec 0c             	sub    $0xc,%esp
 4d8:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 4de:	50                   	push   %eax
 4df:	e8 6e fd ff ff       	call   252 <strlen>
 4e4:	83 c4 10             	add    $0x10,%esp
 4e7:	89 c3                	mov    %eax,%ebx
 4e9:	83 ec 0c             	sub    $0xc,%esp
 4ec:	ff 75 08             	pushl  0x8(%ebp)
 4ef:	e8 5e fd ff ff       	call   252 <strlen>
 4f4:	83 c4 10             	add    $0x10,%esp
 4f7:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 4fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4fd:	39 c2                	cmp    %eax,%edx
 4ff:	77 a6                	ja     4a7 <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 501:	83 ec 04             	sub    $0x4,%esp
 504:	68 e8 03 00 00       	push   $0x3e8
 509:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 50f:	50                   	push   %eax
 510:	ff 75 f0             	pushl  -0x10(%ebp)
 513:	e8 ae 00 00 00       	call   5c6 <read>
 518:	83 c4 10             	add    $0x10,%esp
 51b:	85 c0                	test   %eax,%eax
 51d:	7f b6                	jg     4d5 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 51f:	83 ec 0c             	sub    $0xc,%esp
 522:	ff 75 f0             	pushl  -0x10(%ebp)
 525:	e8 ac 00 00 00       	call   5d6 <close>
 52a:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 52d:	83 ec 08             	sub    $0x8,%esp
 530:	68 02 02 00 00       	push   $0x202
 535:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 538:	50                   	push   %eax
 539:	e8 b0 00 00 00       	call   5ee <open>
 53e:	83 c4 10             	add    $0x10,%esp
 541:	89 45 f0             	mov    %eax,-0x10(%ebp)
 544:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 548:	79 1b                	jns    565 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 54a:	83 ec 04             	sub    $0x4,%esp
 54d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 550:	50                   	push   %eax
 551:	68 14 0b 00 00       	push   $0xb14
 556:	6a 01                	push   $0x1
 558:	e8 c8 01 00 00       	call   725 <printf>
 55d:	83 c4 10             	add    $0x10,%esp
       exit();
 560:	e8 49 00 00 00       	call   5ae <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 565:	83 ec 04             	sub    $0x4,%esp
 568:	68 e8 03 00 00       	push   $0x3e8
 56d:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 573:	50                   	push   %eax
 574:	ff 75 f0             	pushl  -0x10(%ebp)
 577:	e8 52 00 00 00       	call   5ce <write>
 57c:	83 c4 10             	add    $0x10,%esp
 57f:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 584:	74 1a                	je     5a0 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 586:	83 ec 04             	sub    $0x4,%esp
 589:	ff 75 f4             	pushl  -0xc(%ebp)
 58c:	68 30 0b 00 00       	push   $0xb30
 591:	6a 01                	push   $0x1
 593:	e8 8d 01 00 00       	call   725 <printf>
 598:	83 c4 10             	add    $0x10,%esp
       exit();
 59b:	e8 0e 00 00 00       	call   5ae <exit>
     }
    
}
 5a0:	90                   	nop
 5a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5a4:	c9                   	leave  
 5a5:	c3                   	ret    

000005a6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5a6:	b8 01 00 00 00       	mov    $0x1,%eax
 5ab:	cd 40                	int    $0x40
 5ad:	c3                   	ret    

000005ae <exit>:
SYSCALL(exit)
 5ae:	b8 02 00 00 00       	mov    $0x2,%eax
 5b3:	cd 40                	int    $0x40
 5b5:	c3                   	ret    

000005b6 <wait>:
SYSCALL(wait)
 5b6:	b8 03 00 00 00       	mov    $0x3,%eax
 5bb:	cd 40                	int    $0x40
 5bd:	c3                   	ret    

000005be <pipe>:
SYSCALL(pipe)
 5be:	b8 04 00 00 00       	mov    $0x4,%eax
 5c3:	cd 40                	int    $0x40
 5c5:	c3                   	ret    

000005c6 <read>:
SYSCALL(read)
 5c6:	b8 05 00 00 00       	mov    $0x5,%eax
 5cb:	cd 40                	int    $0x40
 5cd:	c3                   	ret    

000005ce <write>:
SYSCALL(write)
 5ce:	b8 10 00 00 00       	mov    $0x10,%eax
 5d3:	cd 40                	int    $0x40
 5d5:	c3                   	ret    

000005d6 <close>:
SYSCALL(close)
 5d6:	b8 15 00 00 00       	mov    $0x15,%eax
 5db:	cd 40                	int    $0x40
 5dd:	c3                   	ret    

000005de <kill>:
SYSCALL(kill)
 5de:	b8 06 00 00 00       	mov    $0x6,%eax
 5e3:	cd 40                	int    $0x40
 5e5:	c3                   	ret    

000005e6 <exec>:
SYSCALL(exec)
 5e6:	b8 07 00 00 00       	mov    $0x7,%eax
 5eb:	cd 40                	int    $0x40
 5ed:	c3                   	ret    

000005ee <open>:
SYSCALL(open)
 5ee:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f3:	cd 40                	int    $0x40
 5f5:	c3                   	ret    

000005f6 <mknod>:
SYSCALL(mknod)
 5f6:	b8 11 00 00 00       	mov    $0x11,%eax
 5fb:	cd 40                	int    $0x40
 5fd:	c3                   	ret    

000005fe <unlink>:
SYSCALL(unlink)
 5fe:	b8 12 00 00 00       	mov    $0x12,%eax
 603:	cd 40                	int    $0x40
 605:	c3                   	ret    

00000606 <fstat>:
SYSCALL(fstat)
 606:	b8 08 00 00 00       	mov    $0x8,%eax
 60b:	cd 40                	int    $0x40
 60d:	c3                   	ret    

0000060e <link>:
SYSCALL(link)
 60e:	b8 13 00 00 00       	mov    $0x13,%eax
 613:	cd 40                	int    $0x40
 615:	c3                   	ret    

00000616 <mkdir>:
SYSCALL(mkdir)
 616:	b8 14 00 00 00       	mov    $0x14,%eax
 61b:	cd 40                	int    $0x40
 61d:	c3                   	ret    

0000061e <chdir>:
SYSCALL(chdir)
 61e:	b8 09 00 00 00       	mov    $0x9,%eax
 623:	cd 40                	int    $0x40
 625:	c3                   	ret    

00000626 <dup>:
SYSCALL(dup)
 626:	b8 0a 00 00 00       	mov    $0xa,%eax
 62b:	cd 40                	int    $0x40
 62d:	c3                   	ret    

0000062e <getpid>:
SYSCALL(getpid)
 62e:	b8 0b 00 00 00       	mov    $0xb,%eax
 633:	cd 40                	int    $0x40
 635:	c3                   	ret    

00000636 <sbrk>:
SYSCALL(sbrk)
 636:	b8 0c 00 00 00       	mov    $0xc,%eax
 63b:	cd 40                	int    $0x40
 63d:	c3                   	ret    

0000063e <sleep>:
SYSCALL(sleep)
 63e:	b8 0d 00 00 00       	mov    $0xd,%eax
 643:	cd 40                	int    $0x40
 645:	c3                   	ret    

00000646 <uptime>:
SYSCALL(uptime)
 646:	b8 0e 00 00 00       	mov    $0xe,%eax
 64b:	cd 40                	int    $0x40
 64d:	c3                   	ret    

0000064e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 64e:	55                   	push   %ebp
 64f:	89 e5                	mov    %esp,%ebp
 651:	83 ec 18             	sub    $0x18,%esp
 654:	8b 45 0c             	mov    0xc(%ebp),%eax
 657:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 65a:	83 ec 04             	sub    $0x4,%esp
 65d:	6a 01                	push   $0x1
 65f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 662:	50                   	push   %eax
 663:	ff 75 08             	pushl  0x8(%ebp)
 666:	e8 63 ff ff ff       	call   5ce <write>
 66b:	83 c4 10             	add    $0x10,%esp
}
 66e:	90                   	nop
 66f:	c9                   	leave  
 670:	c3                   	ret    

00000671 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 671:	55                   	push   %ebp
 672:	89 e5                	mov    %esp,%ebp
 674:	53                   	push   %ebx
 675:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 678:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 67f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 683:	74 17                	je     69c <printint+0x2b>
 685:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 689:	79 11                	jns    69c <printint+0x2b>
    neg = 1;
 68b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 692:	8b 45 0c             	mov    0xc(%ebp),%eax
 695:	f7 d8                	neg    %eax
 697:	89 45 ec             	mov    %eax,-0x14(%ebp)
 69a:	eb 06                	jmp    6a2 <printint+0x31>
  } else {
    x = xx;
 69c:	8b 45 0c             	mov    0xc(%ebp),%eax
 69f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6a9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 6ac:	8d 41 01             	lea    0x1(%ecx),%eax
 6af:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6b2:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6b8:	ba 00 00 00 00       	mov    $0x0,%edx
 6bd:	f7 f3                	div    %ebx
 6bf:	89 d0                	mov    %edx,%eax
 6c1:	0f b6 80 ec 0d 00 00 	movzbl 0xdec(%eax),%eax
 6c8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 6cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6d2:	ba 00 00 00 00       	mov    $0x0,%edx
 6d7:	f7 f3                	div    %ebx
 6d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6e0:	75 c7                	jne    6a9 <printint+0x38>
  if(neg)
 6e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6e6:	74 2d                	je     715 <printint+0xa4>
    buf[i++] = '-';
 6e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6eb:	8d 50 01             	lea    0x1(%eax),%edx
 6ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6f1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6f6:	eb 1d                	jmp    715 <printint+0xa4>
    putc(fd, buf[i]);
 6f8:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fe:	01 d0                	add    %edx,%eax
 700:	0f b6 00             	movzbl (%eax),%eax
 703:	0f be c0             	movsbl %al,%eax
 706:	83 ec 08             	sub    $0x8,%esp
 709:	50                   	push   %eax
 70a:	ff 75 08             	pushl  0x8(%ebp)
 70d:	e8 3c ff ff ff       	call   64e <putc>
 712:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 715:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 719:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 71d:	79 d9                	jns    6f8 <printint+0x87>
    putc(fd, buf[i]);
}
 71f:	90                   	nop
 720:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 723:	c9                   	leave  
 724:	c3                   	ret    

00000725 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 725:	55                   	push   %ebp
 726:	89 e5                	mov    %esp,%ebp
 728:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 72b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 732:	8d 45 0c             	lea    0xc(%ebp),%eax
 735:	83 c0 04             	add    $0x4,%eax
 738:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 73b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 742:	e9 59 01 00 00       	jmp    8a0 <printf+0x17b>
    c = fmt[i] & 0xff;
 747:	8b 55 0c             	mov    0xc(%ebp),%edx
 74a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74d:	01 d0                	add    %edx,%eax
 74f:	0f b6 00             	movzbl (%eax),%eax
 752:	0f be c0             	movsbl %al,%eax
 755:	25 ff 00 00 00       	and    $0xff,%eax
 75a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 75d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 761:	75 2c                	jne    78f <printf+0x6a>
      if(c == '%'){
 763:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 767:	75 0c                	jne    775 <printf+0x50>
        state = '%';
 769:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 770:	e9 27 01 00 00       	jmp    89c <printf+0x177>
      } else {
        putc(fd, c);
 775:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 778:	0f be c0             	movsbl %al,%eax
 77b:	83 ec 08             	sub    $0x8,%esp
 77e:	50                   	push   %eax
 77f:	ff 75 08             	pushl  0x8(%ebp)
 782:	e8 c7 fe ff ff       	call   64e <putc>
 787:	83 c4 10             	add    $0x10,%esp
 78a:	e9 0d 01 00 00       	jmp    89c <printf+0x177>
      }
    } else if(state == '%'){
 78f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 793:	0f 85 03 01 00 00    	jne    89c <printf+0x177>
      if(c == 'd'){
 799:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 79d:	75 1e                	jne    7bd <printf+0x98>
        printint(fd, *ap, 10, 1);
 79f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7a2:	8b 00                	mov    (%eax),%eax
 7a4:	6a 01                	push   $0x1
 7a6:	6a 0a                	push   $0xa
 7a8:	50                   	push   %eax
 7a9:	ff 75 08             	pushl  0x8(%ebp)
 7ac:	e8 c0 fe ff ff       	call   671 <printint>
 7b1:	83 c4 10             	add    $0x10,%esp
        ap++;
 7b4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7b8:	e9 d8 00 00 00       	jmp    895 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 7bd:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7c1:	74 06                	je     7c9 <printf+0xa4>
 7c3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7c7:	75 1e                	jne    7e7 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 7c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7cc:	8b 00                	mov    (%eax),%eax
 7ce:	6a 00                	push   $0x0
 7d0:	6a 10                	push   $0x10
 7d2:	50                   	push   %eax
 7d3:	ff 75 08             	pushl  0x8(%ebp)
 7d6:	e8 96 fe ff ff       	call   671 <printint>
 7db:	83 c4 10             	add    $0x10,%esp
        ap++;
 7de:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7e2:	e9 ae 00 00 00       	jmp    895 <printf+0x170>
      } else if(c == 's'){
 7e7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7eb:	75 43                	jne    830 <printf+0x10b>
        s = (char*)*ap;
 7ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7f0:	8b 00                	mov    (%eax),%eax
 7f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7fd:	75 25                	jne    824 <printf+0xff>
          s = "(null)";
 7ff:	c7 45 f4 54 0b 00 00 	movl   $0xb54,-0xc(%ebp)
        while(*s != 0){
 806:	eb 1c                	jmp    824 <printf+0xff>
          putc(fd, *s);
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	0f b6 00             	movzbl (%eax),%eax
 80e:	0f be c0             	movsbl %al,%eax
 811:	83 ec 08             	sub    $0x8,%esp
 814:	50                   	push   %eax
 815:	ff 75 08             	pushl  0x8(%ebp)
 818:	e8 31 fe ff ff       	call   64e <putc>
 81d:	83 c4 10             	add    $0x10,%esp
          s++;
 820:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 824:	8b 45 f4             	mov    -0xc(%ebp),%eax
 827:	0f b6 00             	movzbl (%eax),%eax
 82a:	84 c0                	test   %al,%al
 82c:	75 da                	jne    808 <printf+0xe3>
 82e:	eb 65                	jmp    895 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 830:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 834:	75 1d                	jne    853 <printf+0x12e>
        putc(fd, *ap);
 836:	8b 45 e8             	mov    -0x18(%ebp),%eax
 839:	8b 00                	mov    (%eax),%eax
 83b:	0f be c0             	movsbl %al,%eax
 83e:	83 ec 08             	sub    $0x8,%esp
 841:	50                   	push   %eax
 842:	ff 75 08             	pushl  0x8(%ebp)
 845:	e8 04 fe ff ff       	call   64e <putc>
 84a:	83 c4 10             	add    $0x10,%esp
        ap++;
 84d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 851:	eb 42                	jmp    895 <printf+0x170>
      } else if(c == '%'){
 853:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 857:	75 17                	jne    870 <printf+0x14b>
        putc(fd, c);
 859:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 85c:	0f be c0             	movsbl %al,%eax
 85f:	83 ec 08             	sub    $0x8,%esp
 862:	50                   	push   %eax
 863:	ff 75 08             	pushl  0x8(%ebp)
 866:	e8 e3 fd ff ff       	call   64e <putc>
 86b:	83 c4 10             	add    $0x10,%esp
 86e:	eb 25                	jmp    895 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 870:	83 ec 08             	sub    $0x8,%esp
 873:	6a 25                	push   $0x25
 875:	ff 75 08             	pushl  0x8(%ebp)
 878:	e8 d1 fd ff ff       	call   64e <putc>
 87d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 880:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 883:	0f be c0             	movsbl %al,%eax
 886:	83 ec 08             	sub    $0x8,%esp
 889:	50                   	push   %eax
 88a:	ff 75 08             	pushl  0x8(%ebp)
 88d:	e8 bc fd ff ff       	call   64e <putc>
 892:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 895:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 89c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8a0:	8b 55 0c             	mov    0xc(%ebp),%edx
 8a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a6:	01 d0                	add    %edx,%eax
 8a8:	0f b6 00             	movzbl (%eax),%eax
 8ab:	84 c0                	test   %al,%al
 8ad:	0f 85 94 fe ff ff    	jne    747 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8b3:	90                   	nop
 8b4:	c9                   	leave  
 8b5:	c3                   	ret    

000008b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b6:	55                   	push   %ebp
 8b7:	89 e5                	mov    %esp,%ebp
 8b9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8bc:	8b 45 08             	mov    0x8(%ebp),%eax
 8bf:	83 e8 08             	sub    $0x8,%eax
 8c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c5:	a1 08 0e 00 00       	mov    0xe08,%eax
 8ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8cd:	eb 24                	jmp    8f3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d2:	8b 00                	mov    (%eax),%eax
 8d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8d7:	77 12                	ja     8eb <free+0x35>
 8d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8dc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8df:	77 24                	ja     905 <free+0x4f>
 8e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e4:	8b 00                	mov    (%eax),%eax
 8e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8e9:	77 1a                	ja     905 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ee:	8b 00                	mov    (%eax),%eax
 8f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8f9:	76 d4                	jbe    8cf <free+0x19>
 8fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fe:	8b 00                	mov    (%eax),%eax
 900:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 903:	76 ca                	jbe    8cf <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 905:	8b 45 f8             	mov    -0x8(%ebp),%eax
 908:	8b 40 04             	mov    0x4(%eax),%eax
 90b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 912:	8b 45 f8             	mov    -0x8(%ebp),%eax
 915:	01 c2                	add    %eax,%edx
 917:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91a:	8b 00                	mov    (%eax),%eax
 91c:	39 c2                	cmp    %eax,%edx
 91e:	75 24                	jne    944 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 920:	8b 45 f8             	mov    -0x8(%ebp),%eax
 923:	8b 50 04             	mov    0x4(%eax),%edx
 926:	8b 45 fc             	mov    -0x4(%ebp),%eax
 929:	8b 00                	mov    (%eax),%eax
 92b:	8b 40 04             	mov    0x4(%eax),%eax
 92e:	01 c2                	add    %eax,%edx
 930:	8b 45 f8             	mov    -0x8(%ebp),%eax
 933:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 936:	8b 45 fc             	mov    -0x4(%ebp),%eax
 939:	8b 00                	mov    (%eax),%eax
 93b:	8b 10                	mov    (%eax),%edx
 93d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 940:	89 10                	mov    %edx,(%eax)
 942:	eb 0a                	jmp    94e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 944:	8b 45 fc             	mov    -0x4(%ebp),%eax
 947:	8b 10                	mov    (%eax),%edx
 949:	8b 45 f8             	mov    -0x8(%ebp),%eax
 94c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 94e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 951:	8b 40 04             	mov    0x4(%eax),%eax
 954:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 95b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95e:	01 d0                	add    %edx,%eax
 960:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 963:	75 20                	jne    985 <free+0xcf>
    p->s.size += bp->s.size;
 965:	8b 45 fc             	mov    -0x4(%ebp),%eax
 968:	8b 50 04             	mov    0x4(%eax),%edx
 96b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96e:	8b 40 04             	mov    0x4(%eax),%eax
 971:	01 c2                	add    %eax,%edx
 973:	8b 45 fc             	mov    -0x4(%ebp),%eax
 976:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 979:	8b 45 f8             	mov    -0x8(%ebp),%eax
 97c:	8b 10                	mov    (%eax),%edx
 97e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 981:	89 10                	mov    %edx,(%eax)
 983:	eb 08                	jmp    98d <free+0xd7>
  } else
    p->s.ptr = bp;
 985:	8b 45 fc             	mov    -0x4(%ebp),%eax
 988:	8b 55 f8             	mov    -0x8(%ebp),%edx
 98b:	89 10                	mov    %edx,(%eax)
  freep = p;
 98d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 990:	a3 08 0e 00 00       	mov    %eax,0xe08
}
 995:	90                   	nop
 996:	c9                   	leave  
 997:	c3                   	ret    

00000998 <morecore>:

static Header*
morecore(uint nu)
{
 998:	55                   	push   %ebp
 999:	89 e5                	mov    %esp,%ebp
 99b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 99e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9a5:	77 07                	ja     9ae <morecore+0x16>
    nu = 4096;
 9a7:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9ae:	8b 45 08             	mov    0x8(%ebp),%eax
 9b1:	c1 e0 03             	shl    $0x3,%eax
 9b4:	83 ec 0c             	sub    $0xc,%esp
 9b7:	50                   	push   %eax
 9b8:	e8 79 fc ff ff       	call   636 <sbrk>
 9bd:	83 c4 10             	add    $0x10,%esp
 9c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9c3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9c7:	75 07                	jne    9d0 <morecore+0x38>
    return 0;
 9c9:	b8 00 00 00 00       	mov    $0x0,%eax
 9ce:	eb 26                	jmp    9f6 <morecore+0x5e>
  hp = (Header*)p;
 9d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d9:	8b 55 08             	mov    0x8(%ebp),%edx
 9dc:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e2:	83 c0 08             	add    $0x8,%eax
 9e5:	83 ec 0c             	sub    $0xc,%esp
 9e8:	50                   	push   %eax
 9e9:	e8 c8 fe ff ff       	call   8b6 <free>
 9ee:	83 c4 10             	add    $0x10,%esp
  return freep;
 9f1:	a1 08 0e 00 00       	mov    0xe08,%eax
}
 9f6:	c9                   	leave  
 9f7:	c3                   	ret    

000009f8 <malloc>:

void*
malloc(uint nbytes)
{
 9f8:	55                   	push   %ebp
 9f9:	89 e5                	mov    %esp,%ebp
 9fb:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9fe:	8b 45 08             	mov    0x8(%ebp),%eax
 a01:	83 c0 07             	add    $0x7,%eax
 a04:	c1 e8 03             	shr    $0x3,%eax
 a07:	83 c0 01             	add    $0x1,%eax
 a0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a0d:	a1 08 0e 00 00       	mov    0xe08,%eax
 a12:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a19:	75 23                	jne    a3e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a1b:	c7 45 f0 00 0e 00 00 	movl   $0xe00,-0x10(%ebp)
 a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a25:	a3 08 0e 00 00       	mov    %eax,0xe08
 a2a:	a1 08 0e 00 00       	mov    0xe08,%eax
 a2f:	a3 00 0e 00 00       	mov    %eax,0xe00
    base.s.size = 0;
 a34:	c7 05 04 0e 00 00 00 	movl   $0x0,0xe04
 a3b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a41:	8b 00                	mov    (%eax),%eax
 a43:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a49:	8b 40 04             	mov    0x4(%eax),%eax
 a4c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a4f:	72 4d                	jb     a9e <malloc+0xa6>
      if(p->s.size == nunits)
 a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a54:	8b 40 04             	mov    0x4(%eax),%eax
 a57:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a5a:	75 0c                	jne    a68 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5f:	8b 10                	mov    (%eax),%edx
 a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a64:	89 10                	mov    %edx,(%eax)
 a66:	eb 26                	jmp    a8e <malloc+0x96>
      else {
        p->s.size -= nunits;
 a68:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6b:	8b 40 04             	mov    0x4(%eax),%eax
 a6e:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a71:	89 c2                	mov    %eax,%edx
 a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a76:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a7c:	8b 40 04             	mov    0x4(%eax),%eax
 a7f:	c1 e0 03             	shl    $0x3,%eax
 a82:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a88:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a8b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a91:	a3 08 0e 00 00       	mov    %eax,0xe08
      return (void*)(p + 1);
 a96:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a99:	83 c0 08             	add    $0x8,%eax
 a9c:	eb 3b                	jmp    ad9 <malloc+0xe1>
    }
    if(p == freep)
 a9e:	a1 08 0e 00 00       	mov    0xe08,%eax
 aa3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 aa6:	75 1e                	jne    ac6 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 aa8:	83 ec 0c             	sub    $0xc,%esp
 aab:	ff 75 ec             	pushl  -0x14(%ebp)
 aae:	e8 e5 fe ff ff       	call   998 <morecore>
 ab3:	83 c4 10             	add    $0x10,%esp
 ab6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 ab9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 abd:	75 07                	jne    ac6 <malloc+0xce>
        return 0;
 abf:	b8 00 00 00 00       	mov    $0x0,%eax
 ac4:	eb 13                	jmp    ad9 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acf:	8b 00                	mov    (%eax),%eax
 ad1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 ad4:	e9 6d ff ff ff       	jmp    a46 <malloc+0x4e>
}
 ad9:	c9                   	leave  
 ada:	c3                   	ret    
