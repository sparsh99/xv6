
_echo:     file format elf32-i386


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

  for(i = 1; i < argc; i++)
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  20:	83 c0 01             	add    $0x1,%eax
  23:	3b 03                	cmp    (%ebx),%eax
  25:	7d 07                	jge    2e <main+0x2e>
  27:	ba 84 09 00 00       	mov    $0x984,%edx
  2c:	eb 05                	jmp    33 <main+0x33>
  2e:	ba 86 09 00 00       	mov    $0x986,%edx
  33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  3d:	8b 43 04             	mov    0x4(%ebx),%eax
  40:	01 c8                	add    %ecx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	52                   	push   %edx
  45:	50                   	push   %eax
  46:	68 88 09 00 00       	push   $0x988
  4b:	6a 01                	push   $0x1
  4d:	e8 7b 05 00 00       	call   5cd <printf>
  52:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5c:	3b 03                	cmp    (%ebx),%eax
  5e:	7c bd                	jl     1d <main+0x1d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  60:	e8 f1 03 00 00       	call   456 <exit>

00000065 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  65:	55                   	push   %ebp
  66:	89 e5                	mov    %esp,%ebp
  68:	57                   	push   %edi
  69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6d:	8b 55 10             	mov    0x10(%ebp),%edx
  70:	8b 45 0c             	mov    0xc(%ebp),%eax
  73:	89 cb                	mov    %ecx,%ebx
  75:	89 df                	mov    %ebx,%edi
  77:	89 d1                	mov    %edx,%ecx
  79:	fc                   	cld    
  7a:	f3 aa                	rep stos %al,%es:(%edi)
  7c:	89 ca                	mov    %ecx,%edx
  7e:	89 fb                	mov    %edi,%ebx
  80:	89 5d 08             	mov    %ebx,0x8(%ebp)
  83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  86:	90                   	nop
  87:	5b                   	pop    %ebx
  88:	5f                   	pop    %edi
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    

0000008b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8b:	55                   	push   %ebp
  8c:	89 e5                	mov    %esp,%ebp
  8e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  91:	8b 45 08             	mov    0x8(%ebp),%eax
  94:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  97:	90                   	nop
  98:	8b 45 08             	mov    0x8(%ebp),%eax
  9b:	8d 50 01             	lea    0x1(%eax),%edx
  9e:	89 55 08             	mov    %edx,0x8(%ebp)
  a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  a4:	8d 4a 01             	lea    0x1(%edx),%ecx
  a7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  aa:	0f b6 12             	movzbl (%edx),%edx
  ad:	88 10                	mov    %dl,(%eax)
  af:	0f b6 00             	movzbl (%eax),%eax
  b2:	84 c0                	test   %al,%al
  b4:	75 e2                	jne    98 <strcpy+0xd>
    ;
  return os;
  b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b9:	c9                   	leave  
  ba:	c3                   	ret    

000000bb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bb:	55                   	push   %ebp
  bc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  be:	eb 08                	jmp    c8 <strcmp+0xd>
    p++, q++;
  c0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	0f b6 00             	movzbl (%eax),%eax
  ce:	84 c0                	test   %al,%al
  d0:	74 10                	je     e2 <strcmp+0x27>
  d2:	8b 45 08             	mov    0x8(%ebp),%eax
  d5:	0f b6 10             	movzbl (%eax),%edx
  d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  db:	0f b6 00             	movzbl (%eax),%eax
  de:	38 c2                	cmp    %al,%dl
  e0:	74 de                	je     c0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	0f b6 00             	movzbl (%eax),%eax
  e8:	0f b6 d0             	movzbl %al,%edx
  eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ee:	0f b6 00             	movzbl (%eax),%eax
  f1:	0f b6 c0             	movzbl %al,%eax
  f4:	29 c2                	sub    %eax,%edx
  f6:	89 d0                	mov    %edx,%eax
}
  f8:	5d                   	pop    %ebp
  f9:	c3                   	ret    

000000fa <strlen>:

uint
strlen(char *s)
{
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 107:	eb 04                	jmp    10d <strlen+0x13>
 109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	01 d0                	add    %edx,%eax
 115:	0f b6 00             	movzbl (%eax),%eax
 118:	84 c0                	test   %al,%al
 11a:	75 ed                	jne    109 <strlen+0xf>
    ;
  return n;
 11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11f:	c9                   	leave  
 120:	c3                   	ret    

00000121 <memset>:

void*
memset(void *dst, int c, uint n)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 124:	8b 45 10             	mov    0x10(%ebp),%eax
 127:	50                   	push   %eax
 128:	ff 75 0c             	pushl  0xc(%ebp)
 12b:	ff 75 08             	pushl  0x8(%ebp)
 12e:	e8 32 ff ff ff       	call   65 <stosb>
 133:	83 c4 0c             	add    $0xc,%esp
  return dst;
 136:	8b 45 08             	mov    0x8(%ebp),%eax
}
 139:	c9                   	leave  
 13a:	c3                   	ret    

0000013b <strchr>:

char*
strchr(const char *s, char c)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	83 ec 04             	sub    $0x4,%esp
 141:	8b 45 0c             	mov    0xc(%ebp),%eax
 144:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 147:	eb 14                	jmp    15d <strchr+0x22>
    if(*s == c)
 149:	8b 45 08             	mov    0x8(%ebp),%eax
 14c:	0f b6 00             	movzbl (%eax),%eax
 14f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 152:	75 05                	jne    159 <strchr+0x1e>
      return (char*)s;
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	eb 13                	jmp    16c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 159:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	0f b6 00             	movzbl (%eax),%eax
 163:	84 c0                	test   %al,%al
 165:	75 e2                	jne    149 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 167:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16c:	c9                   	leave  
 16d:	c3                   	ret    

0000016e <gets>:

char*
gets(char *buf, int max)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 174:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17b:	eb 42                	jmp    1bf <gets+0x51>
    cc = read(0, &c, 1);
 17d:	83 ec 04             	sub    $0x4,%esp
 180:	6a 01                	push   $0x1
 182:	8d 45 ef             	lea    -0x11(%ebp),%eax
 185:	50                   	push   %eax
 186:	6a 00                	push   $0x0
 188:	e8 e1 02 00 00       	call   46e <read>
 18d:	83 c4 10             	add    $0x10,%esp
 190:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 193:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 197:	7e 33                	jle    1cc <gets+0x5e>
      break;
    buf[i++] = c;
 199:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19c:	8d 50 01             	lea    0x1(%eax),%edx
 19f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a2:	89 c2                	mov    %eax,%edx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	01 c2                	add    %eax,%edx
 1a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b3:	3c 0a                	cmp    $0xa,%al
 1b5:	74 16                	je     1cd <gets+0x5f>
 1b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bb:	3c 0d                	cmp    $0xd,%al
 1bd:	74 0e                	je     1cd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c2:	83 c0 01             	add    $0x1,%eax
 1c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1c8:	7c b3                	jl     17d <gets+0xf>
 1ca:	eb 01                	jmp    1cd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1cc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	01 d0                	add    %edx,%eax
 1d5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1db:	c9                   	leave  
 1dc:	c3                   	ret    

000001dd <stat>:

int
stat(char *n, struct stat *st)
{
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
 1e0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e3:	83 ec 08             	sub    $0x8,%esp
 1e6:	6a 00                	push   $0x0
 1e8:	ff 75 08             	pushl  0x8(%ebp)
 1eb:	e8 a6 02 00 00       	call   496 <open>
 1f0:	83 c4 10             	add    $0x10,%esp
 1f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1fa:	79 07                	jns    203 <stat+0x26>
    return -1;
 1fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 201:	eb 25                	jmp    228 <stat+0x4b>
  r = fstat(fd, st);
 203:	83 ec 08             	sub    $0x8,%esp
 206:	ff 75 0c             	pushl  0xc(%ebp)
 209:	ff 75 f4             	pushl  -0xc(%ebp)
 20c:	e8 9d 02 00 00       	call   4ae <fstat>
 211:	83 c4 10             	add    $0x10,%esp
 214:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 217:	83 ec 0c             	sub    $0xc,%esp
 21a:	ff 75 f4             	pushl  -0xc(%ebp)
 21d:	e8 5c 02 00 00       	call   47e <close>
 222:	83 c4 10             	add    $0x10,%esp
  return r;
 225:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <atoi>:

int
atoi(const char *s)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 237:	eb 25                	jmp    25e <atoi+0x34>
    n = n*10 + *s++ - '0';
 239:	8b 55 fc             	mov    -0x4(%ebp),%edx
 23c:	89 d0                	mov    %edx,%eax
 23e:	c1 e0 02             	shl    $0x2,%eax
 241:	01 d0                	add    %edx,%eax
 243:	01 c0                	add    %eax,%eax
 245:	89 c1                	mov    %eax,%ecx
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	8d 50 01             	lea    0x1(%eax),%edx
 24d:	89 55 08             	mov    %edx,0x8(%ebp)
 250:	0f b6 00             	movzbl (%eax),%eax
 253:	0f be c0             	movsbl %al,%eax
 256:	01 c8                	add    %ecx,%eax
 258:	83 e8 30             	sub    $0x30,%eax
 25b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	0f b6 00             	movzbl (%eax),%eax
 264:	3c 2f                	cmp    $0x2f,%al
 266:	7e 0a                	jle    272 <atoi+0x48>
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	0f b6 00             	movzbl (%eax),%eax
 26e:	3c 39                	cmp    $0x39,%al
 270:	7e c7                	jle    239 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 272:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 275:	c9                   	leave  
 276:	c3                   	ret    

00000277 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 277:	55                   	push   %ebp
 278:	89 e5                	mov    %esp,%ebp
 27a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 283:	8b 45 0c             	mov    0xc(%ebp),%eax
 286:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 289:	eb 17                	jmp    2a2 <memmove+0x2b>
    *dst++ = *src++;
 28b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 28e:	8d 50 01             	lea    0x1(%eax),%edx
 291:	89 55 fc             	mov    %edx,-0x4(%ebp)
 294:	8b 55 f8             	mov    -0x8(%ebp),%edx
 297:	8d 4a 01             	lea    0x1(%edx),%ecx
 29a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 29d:	0f b6 12             	movzbl (%edx),%edx
 2a0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a2:	8b 45 10             	mov    0x10(%ebp),%eax
 2a5:	8d 50 ff             	lea    -0x1(%eax),%edx
 2a8:	89 55 10             	mov    %edx,0x10(%ebp)
 2ab:	85 c0                	test   %eax,%eax
 2ad:	7f dc                	jg     28b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b2:	c9                   	leave  
 2b3:	c3                   	ret    

000002b4 <historyAdd>:

void
historyAdd(char *buf1){
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	53                   	push   %ebx
 2b8:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 2be:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 2c5:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 2cc:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 2d2:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 2d6:	83 ec 08             	sub    $0x8,%esp
 2d9:	6a 00                	push   $0x0
 2db:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 2de:	50                   	push   %eax
 2df:	e8 b2 01 00 00       	call   496 <open>
 2e4:	83 c4 10             	add    $0x10,%esp
 2e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2ee:	79 1b                	jns    30b <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 2f0:	83 ec 04             	sub    $0x4,%esp
 2f3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 2f6:	50                   	push   %eax
 2f7:	68 90 09 00 00       	push   $0x990
 2fc:	6a 01                	push   $0x1
 2fe:	e8 ca 02 00 00       	call   5cd <printf>
 303:	83 c4 10             	add    $0x10,%esp
       exit();
 306:	e8 4b 01 00 00       	call   456 <exit>
     }

     int i=0;
 30b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 312:	eb 1c                	jmp    330 <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 314:	8b 55 f4             	mov    -0xc(%ebp),%edx
 317:	8b 45 08             	mov    0x8(%ebp),%eax
 31a:	01 d0                	add    %edx,%eax
 31c:	0f b6 00             	movzbl (%eax),%eax
 31f:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 325:	8b 55 f4             	mov    -0xc(%ebp),%edx
 328:	01 ca                	add    %ecx,%edx
 32a:	88 02                	mov    %al,(%edx)
	i++;
 32c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 330:	8b 55 f4             	mov    -0xc(%ebp),%edx
 333:	8b 45 08             	mov    0x8(%ebp),%eax
 336:	01 d0                	add    %edx,%eax
 338:	0f b6 00             	movzbl (%eax),%eax
 33b:	84 c0                	test   %al,%al
 33d:	75 d5                	jne    314 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 33f:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 345:	8b 45 f4             	mov    -0xc(%ebp),%eax
 348:	01 d0                	add    %edx,%eax
 34a:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 34d:	eb 5a                	jmp    3a9 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 34f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 352:	83 ec 0c             	sub    $0xc,%esp
 355:	ff 75 08             	pushl  0x8(%ebp)
 358:	e8 9d fd ff ff       	call   fa <strlen>
 35d:	83 c4 10             	add    $0x10,%esp
 360:	29 c3                	sub    %eax,%ebx
 362:	89 d8                	mov    %ebx,%eax
 364:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 36b:	ff 
 36c:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 372:	8b 55 f4             	mov    -0xc(%ebp),%edx
 375:	01 ca                	add    %ecx,%edx
 377:	88 02                	mov    %al,(%edx)
		i++;
 379:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 37d:	83 ec 0c             	sub    $0xc,%esp
 380:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 386:	50                   	push   %eax
 387:	e8 6e fd ff ff       	call   fa <strlen>
 38c:	83 c4 10             	add    $0x10,%esp
 38f:	89 c3                	mov    %eax,%ebx
 391:	83 ec 0c             	sub    $0xc,%esp
 394:	ff 75 08             	pushl  0x8(%ebp)
 397:	e8 5e fd ff ff       	call   fa <strlen>
 39c:	83 c4 10             	add    $0x10,%esp
 39f:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 3a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a5:	39 c2                	cmp    %eax,%edx
 3a7:	77 a6                	ja     34f <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 3a9:	83 ec 04             	sub    $0x4,%esp
 3ac:	68 e8 03 00 00       	push   $0x3e8
 3b1:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 3b7:	50                   	push   %eax
 3b8:	ff 75 f0             	pushl  -0x10(%ebp)
 3bb:	e8 ae 00 00 00       	call   46e <read>
 3c0:	83 c4 10             	add    $0x10,%esp
 3c3:	85 c0                	test   %eax,%eax
 3c5:	7f b6                	jg     37d <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 3c7:	83 ec 0c             	sub    $0xc,%esp
 3ca:	ff 75 f0             	pushl  -0x10(%ebp)
 3cd:	e8 ac 00 00 00       	call   47e <close>
 3d2:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 3d5:	83 ec 08             	sub    $0x8,%esp
 3d8:	68 02 02 00 00       	push   $0x202
 3dd:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3e0:	50                   	push   %eax
 3e1:	e8 b0 00 00 00       	call   496 <open>
 3e6:	83 c4 10             	add    $0x10,%esp
 3e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 3ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3f0:	79 1b                	jns    40d <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 3f2:	83 ec 04             	sub    $0x4,%esp
 3f5:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3f8:	50                   	push   %eax
 3f9:	68 90 09 00 00       	push   $0x990
 3fe:	6a 01                	push   $0x1
 400:	e8 c8 01 00 00       	call   5cd <printf>
 405:	83 c4 10             	add    $0x10,%esp
       exit();
 408:	e8 49 00 00 00       	call   456 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 40d:	83 ec 04             	sub    $0x4,%esp
 410:	68 e8 03 00 00       	push   $0x3e8
 415:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 41b:	50                   	push   %eax
 41c:	ff 75 f0             	pushl  -0x10(%ebp)
 41f:	e8 52 00 00 00       	call   476 <write>
 424:	83 c4 10             	add    $0x10,%esp
 427:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 42c:	74 1a                	je     448 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 42e:	83 ec 04             	sub    $0x4,%esp
 431:	ff 75 f4             	pushl  -0xc(%ebp)
 434:	68 ac 09 00 00       	push   $0x9ac
 439:	6a 01                	push   $0x1
 43b:	e8 8d 01 00 00       	call   5cd <printf>
 440:	83 c4 10             	add    $0x10,%esp
       exit();
 443:	e8 0e 00 00 00       	call   456 <exit>
     }
    
}
 448:	90                   	nop
 449:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44c:	c9                   	leave  
 44d:	c3                   	ret    

0000044e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 44e:	b8 01 00 00 00       	mov    $0x1,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret    

00000456 <exit>:
SYSCALL(exit)
 456:	b8 02 00 00 00       	mov    $0x2,%eax
 45b:	cd 40                	int    $0x40
 45d:	c3                   	ret    

0000045e <wait>:
SYSCALL(wait)
 45e:	b8 03 00 00 00       	mov    $0x3,%eax
 463:	cd 40                	int    $0x40
 465:	c3                   	ret    

00000466 <pipe>:
SYSCALL(pipe)
 466:	b8 04 00 00 00       	mov    $0x4,%eax
 46b:	cd 40                	int    $0x40
 46d:	c3                   	ret    

0000046e <read>:
SYSCALL(read)
 46e:	b8 05 00 00 00       	mov    $0x5,%eax
 473:	cd 40                	int    $0x40
 475:	c3                   	ret    

00000476 <write>:
SYSCALL(write)
 476:	b8 10 00 00 00       	mov    $0x10,%eax
 47b:	cd 40                	int    $0x40
 47d:	c3                   	ret    

0000047e <close>:
SYSCALL(close)
 47e:	b8 15 00 00 00       	mov    $0x15,%eax
 483:	cd 40                	int    $0x40
 485:	c3                   	ret    

00000486 <kill>:
SYSCALL(kill)
 486:	b8 06 00 00 00       	mov    $0x6,%eax
 48b:	cd 40                	int    $0x40
 48d:	c3                   	ret    

0000048e <exec>:
SYSCALL(exec)
 48e:	b8 07 00 00 00       	mov    $0x7,%eax
 493:	cd 40                	int    $0x40
 495:	c3                   	ret    

00000496 <open>:
SYSCALL(open)
 496:	b8 0f 00 00 00       	mov    $0xf,%eax
 49b:	cd 40                	int    $0x40
 49d:	c3                   	ret    

0000049e <mknod>:
SYSCALL(mknod)
 49e:	b8 11 00 00 00       	mov    $0x11,%eax
 4a3:	cd 40                	int    $0x40
 4a5:	c3                   	ret    

000004a6 <unlink>:
SYSCALL(unlink)
 4a6:	b8 12 00 00 00       	mov    $0x12,%eax
 4ab:	cd 40                	int    $0x40
 4ad:	c3                   	ret    

000004ae <fstat>:
SYSCALL(fstat)
 4ae:	b8 08 00 00 00       	mov    $0x8,%eax
 4b3:	cd 40                	int    $0x40
 4b5:	c3                   	ret    

000004b6 <link>:
SYSCALL(link)
 4b6:	b8 13 00 00 00       	mov    $0x13,%eax
 4bb:	cd 40                	int    $0x40
 4bd:	c3                   	ret    

000004be <mkdir>:
SYSCALL(mkdir)
 4be:	b8 14 00 00 00       	mov    $0x14,%eax
 4c3:	cd 40                	int    $0x40
 4c5:	c3                   	ret    

000004c6 <chdir>:
SYSCALL(chdir)
 4c6:	b8 09 00 00 00       	mov    $0x9,%eax
 4cb:	cd 40                	int    $0x40
 4cd:	c3                   	ret    

000004ce <dup>:
SYSCALL(dup)
 4ce:	b8 0a 00 00 00       	mov    $0xa,%eax
 4d3:	cd 40                	int    $0x40
 4d5:	c3                   	ret    

000004d6 <getpid>:
SYSCALL(getpid)
 4d6:	b8 0b 00 00 00       	mov    $0xb,%eax
 4db:	cd 40                	int    $0x40
 4dd:	c3                   	ret    

000004de <sbrk>:
SYSCALL(sbrk)
 4de:	b8 0c 00 00 00       	mov    $0xc,%eax
 4e3:	cd 40                	int    $0x40
 4e5:	c3                   	ret    

000004e6 <sleep>:
SYSCALL(sleep)
 4e6:	b8 0d 00 00 00       	mov    $0xd,%eax
 4eb:	cd 40                	int    $0x40
 4ed:	c3                   	ret    

000004ee <uptime>:
SYSCALL(uptime)
 4ee:	b8 0e 00 00 00       	mov    $0xe,%eax
 4f3:	cd 40                	int    $0x40
 4f5:	c3                   	ret    

000004f6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4f6:	55                   	push   %ebp
 4f7:	89 e5                	mov    %esp,%ebp
 4f9:	83 ec 18             	sub    $0x18,%esp
 4fc:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ff:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 502:	83 ec 04             	sub    $0x4,%esp
 505:	6a 01                	push   $0x1
 507:	8d 45 f4             	lea    -0xc(%ebp),%eax
 50a:	50                   	push   %eax
 50b:	ff 75 08             	pushl  0x8(%ebp)
 50e:	e8 63 ff ff ff       	call   476 <write>
 513:	83 c4 10             	add    $0x10,%esp
}
 516:	90                   	nop
 517:	c9                   	leave  
 518:	c3                   	ret    

00000519 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 519:	55                   	push   %ebp
 51a:	89 e5                	mov    %esp,%ebp
 51c:	53                   	push   %ebx
 51d:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 520:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 527:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 52b:	74 17                	je     544 <printint+0x2b>
 52d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 531:	79 11                	jns    544 <printint+0x2b>
    neg = 1;
 533:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 53a:	8b 45 0c             	mov    0xc(%ebp),%eax
 53d:	f7 d8                	neg    %eax
 53f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 542:	eb 06                	jmp    54a <printint+0x31>
  } else {
    x = xx;
 544:	8b 45 0c             	mov    0xc(%ebp),%eax
 547:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 54a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 551:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 554:	8d 41 01             	lea    0x1(%ecx),%eax
 557:	89 45 f4             	mov    %eax,-0xc(%ebp)
 55a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 55d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 560:	ba 00 00 00 00       	mov    $0x0,%edx
 565:	f7 f3                	div    %ebx
 567:	89 d0                	mov    %edx,%eax
 569:	0f b6 80 48 0c 00 00 	movzbl 0xc48(%eax),%eax
 570:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 574:	8b 5d 10             	mov    0x10(%ebp),%ebx
 577:	8b 45 ec             	mov    -0x14(%ebp),%eax
 57a:	ba 00 00 00 00       	mov    $0x0,%edx
 57f:	f7 f3                	div    %ebx
 581:	89 45 ec             	mov    %eax,-0x14(%ebp)
 584:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 588:	75 c7                	jne    551 <printint+0x38>
  if(neg)
 58a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 58e:	74 2d                	je     5bd <printint+0xa4>
    buf[i++] = '-';
 590:	8b 45 f4             	mov    -0xc(%ebp),%eax
 593:	8d 50 01             	lea    0x1(%eax),%edx
 596:	89 55 f4             	mov    %edx,-0xc(%ebp)
 599:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 59e:	eb 1d                	jmp    5bd <printint+0xa4>
    putc(fd, buf[i]);
 5a0:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a6:	01 d0                	add    %edx,%eax
 5a8:	0f b6 00             	movzbl (%eax),%eax
 5ab:	0f be c0             	movsbl %al,%eax
 5ae:	83 ec 08             	sub    $0x8,%esp
 5b1:	50                   	push   %eax
 5b2:	ff 75 08             	pushl  0x8(%ebp)
 5b5:	e8 3c ff ff ff       	call   4f6 <putc>
 5ba:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5bd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c5:	79 d9                	jns    5a0 <printint+0x87>
    putc(fd, buf[i]);
}
 5c7:	90                   	nop
 5c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5cb:	c9                   	leave  
 5cc:	c3                   	ret    

000005cd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5cd:	55                   	push   %ebp
 5ce:	89 e5                	mov    %esp,%ebp
 5d0:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5d3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5da:	8d 45 0c             	lea    0xc(%ebp),%eax
 5dd:	83 c0 04             	add    $0x4,%eax
 5e0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5ea:	e9 59 01 00 00       	jmp    748 <printf+0x17b>
    c = fmt[i] & 0xff;
 5ef:	8b 55 0c             	mov    0xc(%ebp),%edx
 5f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5f5:	01 d0                	add    %edx,%eax
 5f7:	0f b6 00             	movzbl (%eax),%eax
 5fa:	0f be c0             	movsbl %al,%eax
 5fd:	25 ff 00 00 00       	and    $0xff,%eax
 602:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 605:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 609:	75 2c                	jne    637 <printf+0x6a>
      if(c == '%'){
 60b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 60f:	75 0c                	jne    61d <printf+0x50>
        state = '%';
 611:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 618:	e9 27 01 00 00       	jmp    744 <printf+0x177>
      } else {
        putc(fd, c);
 61d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 620:	0f be c0             	movsbl %al,%eax
 623:	83 ec 08             	sub    $0x8,%esp
 626:	50                   	push   %eax
 627:	ff 75 08             	pushl  0x8(%ebp)
 62a:	e8 c7 fe ff ff       	call   4f6 <putc>
 62f:	83 c4 10             	add    $0x10,%esp
 632:	e9 0d 01 00 00       	jmp    744 <printf+0x177>
      }
    } else if(state == '%'){
 637:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 63b:	0f 85 03 01 00 00    	jne    744 <printf+0x177>
      if(c == 'd'){
 641:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 645:	75 1e                	jne    665 <printf+0x98>
        printint(fd, *ap, 10, 1);
 647:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64a:	8b 00                	mov    (%eax),%eax
 64c:	6a 01                	push   $0x1
 64e:	6a 0a                	push   $0xa
 650:	50                   	push   %eax
 651:	ff 75 08             	pushl  0x8(%ebp)
 654:	e8 c0 fe ff ff       	call   519 <printint>
 659:	83 c4 10             	add    $0x10,%esp
        ap++;
 65c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 660:	e9 d8 00 00 00       	jmp    73d <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 665:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 669:	74 06                	je     671 <printf+0xa4>
 66b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 66f:	75 1e                	jne    68f <printf+0xc2>
        printint(fd, *ap, 16, 0);
 671:	8b 45 e8             	mov    -0x18(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	6a 00                	push   $0x0
 678:	6a 10                	push   $0x10
 67a:	50                   	push   %eax
 67b:	ff 75 08             	pushl  0x8(%ebp)
 67e:	e8 96 fe ff ff       	call   519 <printint>
 683:	83 c4 10             	add    $0x10,%esp
        ap++;
 686:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68a:	e9 ae 00 00 00       	jmp    73d <printf+0x170>
      } else if(c == 's'){
 68f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 693:	75 43                	jne    6d8 <printf+0x10b>
        s = (char*)*ap;
 695:	8b 45 e8             	mov    -0x18(%ebp),%eax
 698:	8b 00                	mov    (%eax),%eax
 69a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 69d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6a5:	75 25                	jne    6cc <printf+0xff>
          s = "(null)";
 6a7:	c7 45 f4 d0 09 00 00 	movl   $0x9d0,-0xc(%ebp)
        while(*s != 0){
 6ae:	eb 1c                	jmp    6cc <printf+0xff>
          putc(fd, *s);
 6b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b3:	0f b6 00             	movzbl (%eax),%eax
 6b6:	0f be c0             	movsbl %al,%eax
 6b9:	83 ec 08             	sub    $0x8,%esp
 6bc:	50                   	push   %eax
 6bd:	ff 75 08             	pushl  0x8(%ebp)
 6c0:	e8 31 fe ff ff       	call   4f6 <putc>
 6c5:	83 c4 10             	add    $0x10,%esp
          s++;
 6c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6cf:	0f b6 00             	movzbl (%eax),%eax
 6d2:	84 c0                	test   %al,%al
 6d4:	75 da                	jne    6b0 <printf+0xe3>
 6d6:	eb 65                	jmp    73d <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6d8:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6dc:	75 1d                	jne    6fb <printf+0x12e>
        putc(fd, *ap);
 6de:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e1:	8b 00                	mov    (%eax),%eax
 6e3:	0f be c0             	movsbl %al,%eax
 6e6:	83 ec 08             	sub    $0x8,%esp
 6e9:	50                   	push   %eax
 6ea:	ff 75 08             	pushl  0x8(%ebp)
 6ed:	e8 04 fe ff ff       	call   4f6 <putc>
 6f2:	83 c4 10             	add    $0x10,%esp
        ap++;
 6f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6f9:	eb 42                	jmp    73d <printf+0x170>
      } else if(c == '%'){
 6fb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6ff:	75 17                	jne    718 <printf+0x14b>
        putc(fd, c);
 701:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 704:	0f be c0             	movsbl %al,%eax
 707:	83 ec 08             	sub    $0x8,%esp
 70a:	50                   	push   %eax
 70b:	ff 75 08             	pushl  0x8(%ebp)
 70e:	e8 e3 fd ff ff       	call   4f6 <putc>
 713:	83 c4 10             	add    $0x10,%esp
 716:	eb 25                	jmp    73d <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 718:	83 ec 08             	sub    $0x8,%esp
 71b:	6a 25                	push   $0x25
 71d:	ff 75 08             	pushl  0x8(%ebp)
 720:	e8 d1 fd ff ff       	call   4f6 <putc>
 725:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 72b:	0f be c0             	movsbl %al,%eax
 72e:	83 ec 08             	sub    $0x8,%esp
 731:	50                   	push   %eax
 732:	ff 75 08             	pushl  0x8(%ebp)
 735:	e8 bc fd ff ff       	call   4f6 <putc>
 73a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 73d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 744:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 748:	8b 55 0c             	mov    0xc(%ebp),%edx
 74b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74e:	01 d0                	add    %edx,%eax
 750:	0f b6 00             	movzbl (%eax),%eax
 753:	84 c0                	test   %al,%al
 755:	0f 85 94 fe ff ff    	jne    5ef <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 75b:	90                   	nop
 75c:	c9                   	leave  
 75d:	c3                   	ret    

0000075e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 75e:	55                   	push   %ebp
 75f:	89 e5                	mov    %esp,%ebp
 761:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 764:	8b 45 08             	mov    0x8(%ebp),%eax
 767:	83 e8 08             	sub    $0x8,%eax
 76a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76d:	a1 64 0c 00 00       	mov    0xc64,%eax
 772:	89 45 fc             	mov    %eax,-0x4(%ebp)
 775:	eb 24                	jmp    79b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 00                	mov    (%eax),%eax
 77c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 77f:	77 12                	ja     793 <free+0x35>
 781:	8b 45 f8             	mov    -0x8(%ebp),%eax
 784:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 787:	77 24                	ja     7ad <free+0x4f>
 789:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78c:	8b 00                	mov    (%eax),%eax
 78e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 791:	77 1a                	ja     7ad <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 793:	8b 45 fc             	mov    -0x4(%ebp),%eax
 796:	8b 00                	mov    (%eax),%eax
 798:	89 45 fc             	mov    %eax,-0x4(%ebp)
 79b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7a1:	76 d4                	jbe    777 <free+0x19>
 7a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a6:	8b 00                	mov    (%eax),%eax
 7a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7ab:	76 ca                	jbe    777 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b0:	8b 40 04             	mov    0x4(%eax),%eax
 7b3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bd:	01 c2                	add    %eax,%edx
 7bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c2:	8b 00                	mov    (%eax),%eax
 7c4:	39 c2                	cmp    %eax,%edx
 7c6:	75 24                	jne    7ec <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cb:	8b 50 04             	mov    0x4(%eax),%edx
 7ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	8b 40 04             	mov    0x4(%eax),%eax
 7d6:	01 c2                	add    %eax,%edx
 7d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7db:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e1:	8b 00                	mov    (%eax),%eax
 7e3:	8b 10                	mov    (%eax),%edx
 7e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e8:	89 10                	mov    %edx,(%eax)
 7ea:	eb 0a                	jmp    7f6 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ef:	8b 10                	mov    (%eax),%edx
 7f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f4:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f9:	8b 40 04             	mov    0x4(%eax),%eax
 7fc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 803:	8b 45 fc             	mov    -0x4(%ebp),%eax
 806:	01 d0                	add    %edx,%eax
 808:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 80b:	75 20                	jne    82d <free+0xcf>
    p->s.size += bp->s.size;
 80d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 810:	8b 50 04             	mov    0x4(%eax),%edx
 813:	8b 45 f8             	mov    -0x8(%ebp),%eax
 816:	8b 40 04             	mov    0x4(%eax),%eax
 819:	01 c2                	add    %eax,%edx
 81b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 821:	8b 45 f8             	mov    -0x8(%ebp),%eax
 824:	8b 10                	mov    (%eax),%edx
 826:	8b 45 fc             	mov    -0x4(%ebp),%eax
 829:	89 10                	mov    %edx,(%eax)
 82b:	eb 08                	jmp    835 <free+0xd7>
  } else
    p->s.ptr = bp;
 82d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 830:	8b 55 f8             	mov    -0x8(%ebp),%edx
 833:	89 10                	mov    %edx,(%eax)
  freep = p;
 835:	8b 45 fc             	mov    -0x4(%ebp),%eax
 838:	a3 64 0c 00 00       	mov    %eax,0xc64
}
 83d:	90                   	nop
 83e:	c9                   	leave  
 83f:	c3                   	ret    

00000840 <morecore>:

static Header*
morecore(uint nu)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 846:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 84d:	77 07                	ja     856 <morecore+0x16>
    nu = 4096;
 84f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 856:	8b 45 08             	mov    0x8(%ebp),%eax
 859:	c1 e0 03             	shl    $0x3,%eax
 85c:	83 ec 0c             	sub    $0xc,%esp
 85f:	50                   	push   %eax
 860:	e8 79 fc ff ff       	call   4de <sbrk>
 865:	83 c4 10             	add    $0x10,%esp
 868:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 86b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 86f:	75 07                	jne    878 <morecore+0x38>
    return 0;
 871:	b8 00 00 00 00       	mov    $0x0,%eax
 876:	eb 26                	jmp    89e <morecore+0x5e>
  hp = (Header*)p;
 878:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 87e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 881:	8b 55 08             	mov    0x8(%ebp),%edx
 884:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 887:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88a:	83 c0 08             	add    $0x8,%eax
 88d:	83 ec 0c             	sub    $0xc,%esp
 890:	50                   	push   %eax
 891:	e8 c8 fe ff ff       	call   75e <free>
 896:	83 c4 10             	add    $0x10,%esp
  return freep;
 899:	a1 64 0c 00 00       	mov    0xc64,%eax
}
 89e:	c9                   	leave  
 89f:	c3                   	ret    

000008a0 <malloc>:

void*
malloc(uint nbytes)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a6:	8b 45 08             	mov    0x8(%ebp),%eax
 8a9:	83 c0 07             	add    $0x7,%eax
 8ac:	c1 e8 03             	shr    $0x3,%eax
 8af:	83 c0 01             	add    $0x1,%eax
 8b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8b5:	a1 64 0c 00 00       	mov    0xc64,%eax
 8ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8c1:	75 23                	jne    8e6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8c3:	c7 45 f0 5c 0c 00 00 	movl   $0xc5c,-0x10(%ebp)
 8ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cd:	a3 64 0c 00 00       	mov    %eax,0xc64
 8d2:	a1 64 0c 00 00       	mov    0xc64,%eax
 8d7:	a3 5c 0c 00 00       	mov    %eax,0xc5c
    base.s.size = 0;
 8dc:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 8e3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e9:	8b 00                	mov    (%eax),%eax
 8eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f1:	8b 40 04             	mov    0x4(%eax),%eax
 8f4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8f7:	72 4d                	jb     946 <malloc+0xa6>
      if(p->s.size == nunits)
 8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fc:	8b 40 04             	mov    0x4(%eax),%eax
 8ff:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 902:	75 0c                	jne    910 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 904:	8b 45 f4             	mov    -0xc(%ebp),%eax
 907:	8b 10                	mov    (%eax),%edx
 909:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90c:	89 10                	mov    %edx,(%eax)
 90e:	eb 26                	jmp    936 <malloc+0x96>
      else {
        p->s.size -= nunits;
 910:	8b 45 f4             	mov    -0xc(%ebp),%eax
 913:	8b 40 04             	mov    0x4(%eax),%eax
 916:	2b 45 ec             	sub    -0x14(%ebp),%eax
 919:	89 c2                	mov    %eax,%edx
 91b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 921:	8b 45 f4             	mov    -0xc(%ebp),%eax
 924:	8b 40 04             	mov    0x4(%eax),%eax
 927:	c1 e0 03             	shl    $0x3,%eax
 92a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 92d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 930:	8b 55 ec             	mov    -0x14(%ebp),%edx
 933:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 936:	8b 45 f0             	mov    -0x10(%ebp),%eax
 939:	a3 64 0c 00 00       	mov    %eax,0xc64
      return (void*)(p + 1);
 93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 941:	83 c0 08             	add    $0x8,%eax
 944:	eb 3b                	jmp    981 <malloc+0xe1>
    }
    if(p == freep)
 946:	a1 64 0c 00 00       	mov    0xc64,%eax
 94b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 94e:	75 1e                	jne    96e <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 950:	83 ec 0c             	sub    $0xc,%esp
 953:	ff 75 ec             	pushl  -0x14(%ebp)
 956:	e8 e5 fe ff ff       	call   840 <morecore>
 95b:	83 c4 10             	add    $0x10,%esp
 95e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 961:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 965:	75 07                	jne    96e <malloc+0xce>
        return 0;
 967:	b8 00 00 00 00       	mov    $0x0,%eax
 96c:	eb 13                	jmp    981 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 971:	89 45 f0             	mov    %eax,-0x10(%ebp)
 974:	8b 45 f4             	mov    -0xc(%ebp),%eax
 977:	8b 00                	mov    (%eax),%eax
 979:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 97c:	e9 6d ff ff ff       	jmp    8ee <malloc+0x4e>
}
 981:	c9                   	leave  
 982:	c3                   	ret    
