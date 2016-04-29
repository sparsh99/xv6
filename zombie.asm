
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 ff 03 00 00       	call   415 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 89 04 00 00       	call   4ad <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 f1 03 00 00       	call   41d <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	57                   	push   %edi
  30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  31:	8b 4d 08             	mov    0x8(%ebp),%ecx
  34:	8b 55 10             	mov    0x10(%ebp),%edx
  37:	8b 45 0c             	mov    0xc(%ebp),%eax
  3a:	89 cb                	mov    %ecx,%ebx
  3c:	89 df                	mov    %ebx,%edi
  3e:	89 d1                	mov    %edx,%ecx
  40:	fc                   	cld    
  41:	f3 aa                	rep stos %al,%es:(%edi)
  43:	89 ca                	mov    %ecx,%edx
  45:	89 fb                	mov    %edi,%ebx
  47:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4d:	90                   	nop
  4e:	5b                   	pop    %ebx
  4f:	5f                   	pop    %edi
  50:	5d                   	pop    %ebp
  51:	c3                   	ret    

00000052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  52:	55                   	push   %ebp
  53:	89 e5                	mov    %esp,%ebp
  55:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  58:	8b 45 08             	mov    0x8(%ebp),%eax
  5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5e:	90                   	nop
  5f:	8b 45 08             	mov    0x8(%ebp),%eax
  62:	8d 50 01             	lea    0x1(%eax),%edx
  65:	89 55 08             	mov    %edx,0x8(%ebp)
  68:	8b 55 0c             	mov    0xc(%ebp),%edx
  6b:	8d 4a 01             	lea    0x1(%edx),%ecx
  6e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  71:	0f b6 12             	movzbl (%edx),%edx
  74:	88 10                	mov    %dl,(%eax)
  76:	0f b6 00             	movzbl (%eax),%eax
  79:	84 c0                	test   %al,%al
  7b:	75 e2                	jne    5f <strcpy+0xd>
    ;
  return os;
  7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80:	c9                   	leave  
  81:	c3                   	ret    

00000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	55                   	push   %ebp
  83:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  85:	eb 08                	jmp    8f <strcmp+0xd>
    p++, q++;
  87:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	0f b6 00             	movzbl (%eax),%eax
  95:	84 c0                	test   %al,%al
  97:	74 10                	je     a9 <strcmp+0x27>
  99:	8b 45 08             	mov    0x8(%ebp),%eax
  9c:	0f b6 10             	movzbl (%eax),%edx
  9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  a2:	0f b6 00             	movzbl (%eax),%eax
  a5:	38 c2                	cmp    %al,%dl
  a7:	74 de                	je     87 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a9:	8b 45 08             	mov    0x8(%ebp),%eax
  ac:	0f b6 00             	movzbl (%eax),%eax
  af:	0f b6 d0             	movzbl %al,%edx
  b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  b5:	0f b6 00             	movzbl (%eax),%eax
  b8:	0f b6 c0             	movzbl %al,%eax
  bb:	29 c2                	sub    %eax,%edx
  bd:	89 d0                	mov    %edx,%eax
}
  bf:	5d                   	pop    %ebp
  c0:	c3                   	ret    

000000c1 <strlen>:

uint
strlen(char *s)
{
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
  c4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  ce:	eb 04                	jmp    d4 <strlen+0x13>
  d0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	01 d0                	add    %edx,%eax
  dc:	0f b6 00             	movzbl (%eax),%eax
  df:	84 c0                	test   %al,%al
  e1:	75 ed                	jne    d0 <strlen+0xf>
    ;
  return n;
  e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e6:	c9                   	leave  
  e7:	c3                   	ret    

000000e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  eb:	8b 45 10             	mov    0x10(%ebp),%eax
  ee:	50                   	push   %eax
  ef:	ff 75 0c             	pushl  0xc(%ebp)
  f2:	ff 75 08             	pushl  0x8(%ebp)
  f5:	e8 32 ff ff ff       	call   2c <stosb>
  fa:	83 c4 0c             	add    $0xc,%esp
  return dst;
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 100:	c9                   	leave  
 101:	c3                   	ret    

00000102 <strchr>:

char*
strchr(const char *s, char c)
{
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	83 ec 04             	sub    $0x4,%esp
 108:	8b 45 0c             	mov    0xc(%ebp),%eax
 10b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10e:	eb 14                	jmp    124 <strchr+0x22>
    if(*s == c)
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	0f b6 00             	movzbl (%eax),%eax
 116:	3a 45 fc             	cmp    -0x4(%ebp),%al
 119:	75 05                	jne    120 <strchr+0x1e>
      return (char*)s;
 11b:	8b 45 08             	mov    0x8(%ebp),%eax
 11e:	eb 13                	jmp    133 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 120:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	0f b6 00             	movzbl (%eax),%eax
 12a:	84 c0                	test   %al,%al
 12c:	75 e2                	jne    110 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 12e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 133:	c9                   	leave  
 134:	c3                   	ret    

00000135 <gets>:

char*
gets(char *buf, int max)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 142:	eb 42                	jmp    186 <gets+0x51>
    cc = read(0, &c, 1);
 144:	83 ec 04             	sub    $0x4,%esp
 147:	6a 01                	push   $0x1
 149:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14c:	50                   	push   %eax
 14d:	6a 00                	push   $0x0
 14f:	e8 e1 02 00 00       	call   435 <read>
 154:	83 c4 10             	add    $0x10,%esp
 157:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 15a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 15e:	7e 33                	jle    193 <gets+0x5e>
      break;
    buf[i++] = c;
 160:	8b 45 f4             	mov    -0xc(%ebp),%eax
 163:	8d 50 01             	lea    0x1(%eax),%edx
 166:	89 55 f4             	mov    %edx,-0xc(%ebp)
 169:	89 c2                	mov    %eax,%edx
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	01 c2                	add    %eax,%edx
 170:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 174:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 176:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17a:	3c 0a                	cmp    $0xa,%al
 17c:	74 16                	je     194 <gets+0x5f>
 17e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 182:	3c 0d                	cmp    $0xd,%al
 184:	74 0e                	je     194 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 186:	8b 45 f4             	mov    -0xc(%ebp),%eax
 189:	83 c0 01             	add    $0x1,%eax
 18c:	3b 45 0c             	cmp    0xc(%ebp),%eax
 18f:	7c b3                	jl     144 <gets+0xf>
 191:	eb 01                	jmp    194 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 193:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 194:	8b 55 f4             	mov    -0xc(%ebp),%edx
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	01 d0                	add    %edx,%eax
 19c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a2:	c9                   	leave  
 1a3:	c3                   	ret    

000001a4 <stat>:

int
stat(char *n, struct stat *st)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1aa:	83 ec 08             	sub    $0x8,%esp
 1ad:	6a 00                	push   $0x0
 1af:	ff 75 08             	pushl  0x8(%ebp)
 1b2:	e8 a6 02 00 00       	call   45d <open>
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c1:	79 07                	jns    1ca <stat+0x26>
    return -1;
 1c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c8:	eb 25                	jmp    1ef <stat+0x4b>
  r = fstat(fd, st);
 1ca:	83 ec 08             	sub    $0x8,%esp
 1cd:	ff 75 0c             	pushl  0xc(%ebp)
 1d0:	ff 75 f4             	pushl  -0xc(%ebp)
 1d3:	e8 9d 02 00 00       	call   475 <fstat>
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1de:	83 ec 0c             	sub    $0xc,%esp
 1e1:	ff 75 f4             	pushl  -0xc(%ebp)
 1e4:	e8 5c 02 00 00       	call   445 <close>
 1e9:	83 c4 10             	add    $0x10,%esp
  return r;
 1ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1ef:	c9                   	leave  
 1f0:	c3                   	ret    

000001f1 <atoi>:

int
atoi(const char *s)
{
 1f1:	55                   	push   %ebp
 1f2:	89 e5                	mov    %esp,%ebp
 1f4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1fe:	eb 25                	jmp    225 <atoi+0x34>
    n = n*10 + *s++ - '0';
 200:	8b 55 fc             	mov    -0x4(%ebp),%edx
 203:	89 d0                	mov    %edx,%eax
 205:	c1 e0 02             	shl    $0x2,%eax
 208:	01 d0                	add    %edx,%eax
 20a:	01 c0                	add    %eax,%eax
 20c:	89 c1                	mov    %eax,%ecx
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
 211:	8d 50 01             	lea    0x1(%eax),%edx
 214:	89 55 08             	mov    %edx,0x8(%ebp)
 217:	0f b6 00             	movzbl (%eax),%eax
 21a:	0f be c0             	movsbl %al,%eax
 21d:	01 c8                	add    %ecx,%eax
 21f:	83 e8 30             	sub    $0x30,%eax
 222:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 225:	8b 45 08             	mov    0x8(%ebp),%eax
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	3c 2f                	cmp    $0x2f,%al
 22d:	7e 0a                	jle    239 <atoi+0x48>
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	3c 39                	cmp    $0x39,%al
 237:	7e c7                	jle    200 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 239:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23c:	c9                   	leave  
 23d:	c3                   	ret    

0000023e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 23e:	55                   	push   %ebp
 23f:	89 e5                	mov    %esp,%ebp
 241:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 250:	eb 17                	jmp    269 <memmove+0x2b>
    *dst++ = *src++;
 252:	8b 45 fc             	mov    -0x4(%ebp),%eax
 255:	8d 50 01             	lea    0x1(%eax),%edx
 258:	89 55 fc             	mov    %edx,-0x4(%ebp)
 25b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 25e:	8d 4a 01             	lea    0x1(%edx),%ecx
 261:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 264:	0f b6 12             	movzbl (%edx),%edx
 267:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 269:	8b 45 10             	mov    0x10(%ebp),%eax
 26c:	8d 50 ff             	lea    -0x1(%eax),%edx
 26f:	89 55 10             	mov    %edx,0x10(%ebp)
 272:	85 c0                	test   %eax,%eax
 274:	7f dc                	jg     252 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 276:	8b 45 08             	mov    0x8(%ebp),%eax
}
 279:	c9                   	leave  
 27a:	c3                   	ret    

0000027b <historyAdd>:

void
historyAdd(char *buf1){
 27b:	55                   	push   %ebp
 27c:	89 e5                	mov    %esp,%ebp
 27e:	53                   	push   %ebx
 27f:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 285:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 28c:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 293:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 299:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 29d:	83 ec 08             	sub    $0x8,%esp
 2a0:	6a 00                	push   $0x0
 2a2:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 2a5:	50                   	push   %eax
 2a6:	e8 b2 01 00 00       	call   45d <open>
 2ab:	83 c4 10             	add    $0x10,%esp
 2ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2b5:	79 1b                	jns    2d2 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 2b7:	83 ec 04             	sub    $0x4,%esp
 2ba:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 2bd:	50                   	push   %eax
 2be:	68 4c 09 00 00       	push   $0x94c
 2c3:	6a 01                	push   $0x1
 2c5:	e8 ca 02 00 00       	call   594 <printf>
 2ca:	83 c4 10             	add    $0x10,%esp
       exit();
 2cd:	e8 4b 01 00 00       	call   41d <exit>
     }

     int i=0;
 2d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 2d9:	eb 1c                	jmp    2f7 <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 2db:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2de:	8b 45 08             	mov    0x8(%ebp),%eax
 2e1:	01 d0                	add    %edx,%eax
 2e3:	0f b6 00             	movzbl (%eax),%eax
 2e6:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 2ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2ef:	01 ca                	add    %ecx,%edx
 2f1:	88 02                	mov    %al,(%edx)
	i++;
 2f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 2f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2fa:	8b 45 08             	mov    0x8(%ebp),%eax
 2fd:	01 d0                	add    %edx,%eax
 2ff:	0f b6 00             	movzbl (%eax),%eax
 302:	84 c0                	test   %al,%al
 304:	75 d5                	jne    2db <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 306:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 30c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 30f:	01 d0                	add    %edx,%eax
 311:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 314:	eb 5a                	jmp    370 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 316:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 319:	83 ec 0c             	sub    $0xc,%esp
 31c:	ff 75 08             	pushl  0x8(%ebp)
 31f:	e8 9d fd ff ff       	call   c1 <strlen>
 324:	83 c4 10             	add    $0x10,%esp
 327:	29 c3                	sub    %eax,%ebx
 329:	89 d8                	mov    %ebx,%eax
 32b:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 332:	ff 
 333:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 339:	8b 55 f4             	mov    -0xc(%ebp),%edx
 33c:	01 ca                	add    %ecx,%edx
 33e:	88 02                	mov    %al,(%edx)
		i++;
 340:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 344:	83 ec 0c             	sub    $0xc,%esp
 347:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 34d:	50                   	push   %eax
 34e:	e8 6e fd ff ff       	call   c1 <strlen>
 353:	83 c4 10             	add    $0x10,%esp
 356:	89 c3                	mov    %eax,%ebx
 358:	83 ec 0c             	sub    $0xc,%esp
 35b:	ff 75 08             	pushl  0x8(%ebp)
 35e:	e8 5e fd ff ff       	call   c1 <strlen>
 363:	83 c4 10             	add    $0x10,%esp
 366:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 369:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36c:	39 c2                	cmp    %eax,%edx
 36e:	77 a6                	ja     316 <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 370:	83 ec 04             	sub    $0x4,%esp
 373:	68 e8 03 00 00       	push   $0x3e8
 378:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 37e:	50                   	push   %eax
 37f:	ff 75 f0             	pushl  -0x10(%ebp)
 382:	e8 ae 00 00 00       	call   435 <read>
 387:	83 c4 10             	add    $0x10,%esp
 38a:	85 c0                	test   %eax,%eax
 38c:	7f b6                	jg     344 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 38e:	83 ec 0c             	sub    $0xc,%esp
 391:	ff 75 f0             	pushl  -0x10(%ebp)
 394:	e8 ac 00 00 00       	call   445 <close>
 399:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 39c:	83 ec 08             	sub    $0x8,%esp
 39f:	68 02 02 00 00       	push   $0x202
 3a4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3a7:	50                   	push   %eax
 3a8:	e8 b0 00 00 00       	call   45d <open>
 3ad:	83 c4 10             	add    $0x10,%esp
 3b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 3b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3b7:	79 1b                	jns    3d4 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 3b9:	83 ec 04             	sub    $0x4,%esp
 3bc:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3bf:	50                   	push   %eax
 3c0:	68 4c 09 00 00       	push   $0x94c
 3c5:	6a 01                	push   $0x1
 3c7:	e8 c8 01 00 00       	call   594 <printf>
 3cc:	83 c4 10             	add    $0x10,%esp
       exit();
 3cf:	e8 49 00 00 00       	call   41d <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 3d4:	83 ec 04             	sub    $0x4,%esp
 3d7:	68 e8 03 00 00       	push   $0x3e8
 3dc:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 3e2:	50                   	push   %eax
 3e3:	ff 75 f0             	pushl  -0x10(%ebp)
 3e6:	e8 52 00 00 00       	call   43d <write>
 3eb:	83 c4 10             	add    $0x10,%esp
 3ee:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 3f3:	74 1a                	je     40f <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 3f5:	83 ec 04             	sub    $0x4,%esp
 3f8:	ff 75 f4             	pushl  -0xc(%ebp)
 3fb:	68 68 09 00 00       	push   $0x968
 400:	6a 01                	push   $0x1
 402:	e8 8d 01 00 00       	call   594 <printf>
 407:	83 c4 10             	add    $0x10,%esp
       exit();
 40a:	e8 0e 00 00 00       	call   41d <exit>
     }
    
}
 40f:	90                   	nop
 410:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 413:	c9                   	leave  
 414:	c3                   	ret    

00000415 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 415:	b8 01 00 00 00       	mov    $0x1,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <exit>:
SYSCALL(exit)
 41d:	b8 02 00 00 00       	mov    $0x2,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <wait>:
SYSCALL(wait)
 425:	b8 03 00 00 00       	mov    $0x3,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <pipe>:
SYSCALL(pipe)
 42d:	b8 04 00 00 00       	mov    $0x4,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <read>:
SYSCALL(read)
 435:	b8 05 00 00 00       	mov    $0x5,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <write>:
SYSCALL(write)
 43d:	b8 10 00 00 00       	mov    $0x10,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <close>:
SYSCALL(close)
 445:	b8 15 00 00 00       	mov    $0x15,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <kill>:
SYSCALL(kill)
 44d:	b8 06 00 00 00       	mov    $0x6,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <exec>:
SYSCALL(exec)
 455:	b8 07 00 00 00       	mov    $0x7,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <open>:
SYSCALL(open)
 45d:	b8 0f 00 00 00       	mov    $0xf,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <mknod>:
SYSCALL(mknod)
 465:	b8 11 00 00 00       	mov    $0x11,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <unlink>:
SYSCALL(unlink)
 46d:	b8 12 00 00 00       	mov    $0x12,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <fstat>:
SYSCALL(fstat)
 475:	b8 08 00 00 00       	mov    $0x8,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <link>:
SYSCALL(link)
 47d:	b8 13 00 00 00       	mov    $0x13,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <mkdir>:
SYSCALL(mkdir)
 485:	b8 14 00 00 00       	mov    $0x14,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <chdir>:
SYSCALL(chdir)
 48d:	b8 09 00 00 00       	mov    $0x9,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <dup>:
SYSCALL(dup)
 495:	b8 0a 00 00 00       	mov    $0xa,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret    

0000049d <getpid>:
SYSCALL(getpid)
 49d:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret    

000004a5 <sbrk>:
SYSCALL(sbrk)
 4a5:	b8 0c 00 00 00       	mov    $0xc,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret    

000004ad <sleep>:
SYSCALL(sleep)
 4ad:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret    

000004b5 <uptime>:
SYSCALL(uptime)
 4b5:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret    

000004bd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4bd:	55                   	push   %ebp
 4be:	89 e5                	mov    %esp,%ebp
 4c0:	83 ec 18             	sub    $0x18,%esp
 4c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4c9:	83 ec 04             	sub    $0x4,%esp
 4cc:	6a 01                	push   $0x1
 4ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	e8 63 ff ff ff       	call   43d <write>
 4da:	83 c4 10             	add    $0x10,%esp
}
 4dd:	90                   	nop
 4de:	c9                   	leave  
 4df:	c3                   	ret    

000004e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	53                   	push   %ebx
 4e4:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4ee:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4f2:	74 17                	je     50b <printint+0x2b>
 4f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4f8:	79 11                	jns    50b <printint+0x2b>
    neg = 1;
 4fa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 501:	8b 45 0c             	mov    0xc(%ebp),%eax
 504:	f7 d8                	neg    %eax
 506:	89 45 ec             	mov    %eax,-0x14(%ebp)
 509:	eb 06                	jmp    511 <printint+0x31>
  } else {
    x = xx;
 50b:	8b 45 0c             	mov    0xc(%ebp),%eax
 50e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 511:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 518:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 51b:	8d 41 01             	lea    0x1(%ecx),%eax
 51e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 521:	8b 5d 10             	mov    0x10(%ebp),%ebx
 524:	8b 45 ec             	mov    -0x14(%ebp),%eax
 527:	ba 00 00 00 00       	mov    $0x0,%edx
 52c:	f7 f3                	div    %ebx
 52e:	89 d0                	mov    %edx,%eax
 530:	0f b6 80 00 0c 00 00 	movzbl 0xc00(%eax),%eax
 537:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 53b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 53e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 541:	ba 00 00 00 00       	mov    $0x0,%edx
 546:	f7 f3                	div    %ebx
 548:	89 45 ec             	mov    %eax,-0x14(%ebp)
 54b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 54f:	75 c7                	jne    518 <printint+0x38>
  if(neg)
 551:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 555:	74 2d                	je     584 <printint+0xa4>
    buf[i++] = '-';
 557:	8b 45 f4             	mov    -0xc(%ebp),%eax
 55a:	8d 50 01             	lea    0x1(%eax),%edx
 55d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 560:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 565:	eb 1d                	jmp    584 <printint+0xa4>
    putc(fd, buf[i]);
 567:	8d 55 dc             	lea    -0x24(%ebp),%edx
 56a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56d:	01 d0                	add    %edx,%eax
 56f:	0f b6 00             	movzbl (%eax),%eax
 572:	0f be c0             	movsbl %al,%eax
 575:	83 ec 08             	sub    $0x8,%esp
 578:	50                   	push   %eax
 579:	ff 75 08             	pushl  0x8(%ebp)
 57c:	e8 3c ff ff ff       	call   4bd <putc>
 581:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 584:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 588:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 58c:	79 d9                	jns    567 <printint+0x87>
    putc(fd, buf[i]);
}
 58e:	90                   	nop
 58f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 592:	c9                   	leave  
 593:	c3                   	ret    

00000594 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 594:	55                   	push   %ebp
 595:	89 e5                	mov    %esp,%ebp
 597:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 59a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5a1:	8d 45 0c             	lea    0xc(%ebp),%eax
 5a4:	83 c0 04             	add    $0x4,%eax
 5a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5b1:	e9 59 01 00 00       	jmp    70f <printf+0x17b>
    c = fmt[i] & 0xff;
 5b6:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bc:	01 d0                	add    %edx,%eax
 5be:	0f b6 00             	movzbl (%eax),%eax
 5c1:	0f be c0             	movsbl %al,%eax
 5c4:	25 ff 00 00 00       	and    $0xff,%eax
 5c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5d0:	75 2c                	jne    5fe <printf+0x6a>
      if(c == '%'){
 5d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d6:	75 0c                	jne    5e4 <printf+0x50>
        state = '%';
 5d8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5df:	e9 27 01 00 00       	jmp    70b <printf+0x177>
      } else {
        putc(fd, c);
 5e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e7:	0f be c0             	movsbl %al,%eax
 5ea:	83 ec 08             	sub    $0x8,%esp
 5ed:	50                   	push   %eax
 5ee:	ff 75 08             	pushl  0x8(%ebp)
 5f1:	e8 c7 fe ff ff       	call   4bd <putc>
 5f6:	83 c4 10             	add    $0x10,%esp
 5f9:	e9 0d 01 00 00       	jmp    70b <printf+0x177>
      }
    } else if(state == '%'){
 5fe:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 602:	0f 85 03 01 00 00    	jne    70b <printf+0x177>
      if(c == 'd'){
 608:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 60c:	75 1e                	jne    62c <printf+0x98>
        printint(fd, *ap, 10, 1);
 60e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 611:	8b 00                	mov    (%eax),%eax
 613:	6a 01                	push   $0x1
 615:	6a 0a                	push   $0xa
 617:	50                   	push   %eax
 618:	ff 75 08             	pushl  0x8(%ebp)
 61b:	e8 c0 fe ff ff       	call   4e0 <printint>
 620:	83 c4 10             	add    $0x10,%esp
        ap++;
 623:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 627:	e9 d8 00 00 00       	jmp    704 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 62c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 630:	74 06                	je     638 <printf+0xa4>
 632:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 636:	75 1e                	jne    656 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 638:	8b 45 e8             	mov    -0x18(%ebp),%eax
 63b:	8b 00                	mov    (%eax),%eax
 63d:	6a 00                	push   $0x0
 63f:	6a 10                	push   $0x10
 641:	50                   	push   %eax
 642:	ff 75 08             	pushl  0x8(%ebp)
 645:	e8 96 fe ff ff       	call   4e0 <printint>
 64a:	83 c4 10             	add    $0x10,%esp
        ap++;
 64d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 651:	e9 ae 00 00 00       	jmp    704 <printf+0x170>
      } else if(c == 's'){
 656:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 65a:	75 43                	jne    69f <printf+0x10b>
        s = (char*)*ap;
 65c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 65f:	8b 00                	mov    (%eax),%eax
 661:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 664:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 668:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 66c:	75 25                	jne    693 <printf+0xff>
          s = "(null)";
 66e:	c7 45 f4 8c 09 00 00 	movl   $0x98c,-0xc(%ebp)
        while(*s != 0){
 675:	eb 1c                	jmp    693 <printf+0xff>
          putc(fd, *s);
 677:	8b 45 f4             	mov    -0xc(%ebp),%eax
 67a:	0f b6 00             	movzbl (%eax),%eax
 67d:	0f be c0             	movsbl %al,%eax
 680:	83 ec 08             	sub    $0x8,%esp
 683:	50                   	push   %eax
 684:	ff 75 08             	pushl  0x8(%ebp)
 687:	e8 31 fe ff ff       	call   4bd <putc>
 68c:	83 c4 10             	add    $0x10,%esp
          s++;
 68f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 693:	8b 45 f4             	mov    -0xc(%ebp),%eax
 696:	0f b6 00             	movzbl (%eax),%eax
 699:	84 c0                	test   %al,%al
 69b:	75 da                	jne    677 <printf+0xe3>
 69d:	eb 65                	jmp    704 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 69f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6a3:	75 1d                	jne    6c2 <printf+0x12e>
        putc(fd, *ap);
 6a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a8:	8b 00                	mov    (%eax),%eax
 6aa:	0f be c0             	movsbl %al,%eax
 6ad:	83 ec 08             	sub    $0x8,%esp
 6b0:	50                   	push   %eax
 6b1:	ff 75 08             	pushl  0x8(%ebp)
 6b4:	e8 04 fe ff ff       	call   4bd <putc>
 6b9:	83 c4 10             	add    $0x10,%esp
        ap++;
 6bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6c0:	eb 42                	jmp    704 <printf+0x170>
      } else if(c == '%'){
 6c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6c6:	75 17                	jne    6df <printf+0x14b>
        putc(fd, c);
 6c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6cb:	0f be c0             	movsbl %al,%eax
 6ce:	83 ec 08             	sub    $0x8,%esp
 6d1:	50                   	push   %eax
 6d2:	ff 75 08             	pushl  0x8(%ebp)
 6d5:	e8 e3 fd ff ff       	call   4bd <putc>
 6da:	83 c4 10             	add    $0x10,%esp
 6dd:	eb 25                	jmp    704 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6df:	83 ec 08             	sub    $0x8,%esp
 6e2:	6a 25                	push   $0x25
 6e4:	ff 75 08             	pushl  0x8(%ebp)
 6e7:	e8 d1 fd ff ff       	call   4bd <putc>
 6ec:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6f2:	0f be c0             	movsbl %al,%eax
 6f5:	83 ec 08             	sub    $0x8,%esp
 6f8:	50                   	push   %eax
 6f9:	ff 75 08             	pushl  0x8(%ebp)
 6fc:	e8 bc fd ff ff       	call   4bd <putc>
 701:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 704:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 70b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 70f:	8b 55 0c             	mov    0xc(%ebp),%edx
 712:	8b 45 f0             	mov    -0x10(%ebp),%eax
 715:	01 d0                	add    %edx,%eax
 717:	0f b6 00             	movzbl (%eax),%eax
 71a:	84 c0                	test   %al,%al
 71c:	0f 85 94 fe ff ff    	jne    5b6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 722:	90                   	nop
 723:	c9                   	leave  
 724:	c3                   	ret    

00000725 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 725:	55                   	push   %ebp
 726:	89 e5                	mov    %esp,%ebp
 728:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 72b:	8b 45 08             	mov    0x8(%ebp),%eax
 72e:	83 e8 08             	sub    $0x8,%eax
 731:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 734:	a1 1c 0c 00 00       	mov    0xc1c,%eax
 739:	89 45 fc             	mov    %eax,-0x4(%ebp)
 73c:	eb 24                	jmp    762 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 741:	8b 00                	mov    (%eax),%eax
 743:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 746:	77 12                	ja     75a <free+0x35>
 748:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 74e:	77 24                	ja     774 <free+0x4f>
 750:	8b 45 fc             	mov    -0x4(%ebp),%eax
 753:	8b 00                	mov    (%eax),%eax
 755:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 758:	77 1a                	ja     774 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75d:	8b 00                	mov    (%eax),%eax
 75f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 762:	8b 45 f8             	mov    -0x8(%ebp),%eax
 765:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 768:	76 d4                	jbe    73e <free+0x19>
 76a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76d:	8b 00                	mov    (%eax),%eax
 76f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 772:	76 ca                	jbe    73e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 774:	8b 45 f8             	mov    -0x8(%ebp),%eax
 777:	8b 40 04             	mov    0x4(%eax),%eax
 77a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 781:	8b 45 f8             	mov    -0x8(%ebp),%eax
 784:	01 c2                	add    %eax,%edx
 786:	8b 45 fc             	mov    -0x4(%ebp),%eax
 789:	8b 00                	mov    (%eax),%eax
 78b:	39 c2                	cmp    %eax,%edx
 78d:	75 24                	jne    7b3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 78f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 792:	8b 50 04             	mov    0x4(%eax),%edx
 795:	8b 45 fc             	mov    -0x4(%ebp),%eax
 798:	8b 00                	mov    (%eax),%eax
 79a:	8b 40 04             	mov    0x4(%eax),%eax
 79d:	01 c2                	add    %eax,%edx
 79f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	8b 10                	mov    (%eax),%edx
 7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7af:	89 10                	mov    %edx,(%eax)
 7b1:	eb 0a                	jmp    7bd <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b6:	8b 10                	mov    (%eax),%edx
 7b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bb:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	8b 40 04             	mov    0x4(%eax),%eax
 7c3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	01 d0                	add    %edx,%eax
 7cf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d2:	75 20                	jne    7f4 <free+0xcf>
    p->s.size += bp->s.size;
 7d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d7:	8b 50 04             	mov    0x4(%eax),%edx
 7da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7dd:	8b 40 04             	mov    0x4(%eax),%eax
 7e0:	01 c2                	add    %eax,%edx
 7e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7eb:	8b 10                	mov    (%eax),%edx
 7ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f0:	89 10                	mov    %edx,(%eax)
 7f2:	eb 08                	jmp    7fc <free+0xd7>
  } else
    p->s.ptr = bp;
 7f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7fa:	89 10                	mov    %edx,(%eax)
  freep = p;
 7fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ff:	a3 1c 0c 00 00       	mov    %eax,0xc1c
}
 804:	90                   	nop
 805:	c9                   	leave  
 806:	c3                   	ret    

00000807 <morecore>:

static Header*
morecore(uint nu)
{
 807:	55                   	push   %ebp
 808:	89 e5                	mov    %esp,%ebp
 80a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 80d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 814:	77 07                	ja     81d <morecore+0x16>
    nu = 4096;
 816:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 81d:	8b 45 08             	mov    0x8(%ebp),%eax
 820:	c1 e0 03             	shl    $0x3,%eax
 823:	83 ec 0c             	sub    $0xc,%esp
 826:	50                   	push   %eax
 827:	e8 79 fc ff ff       	call   4a5 <sbrk>
 82c:	83 c4 10             	add    $0x10,%esp
 82f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 832:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 836:	75 07                	jne    83f <morecore+0x38>
    return 0;
 838:	b8 00 00 00 00       	mov    $0x0,%eax
 83d:	eb 26                	jmp    865 <morecore+0x5e>
  hp = (Header*)p;
 83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 842:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 845:	8b 45 f0             	mov    -0x10(%ebp),%eax
 848:	8b 55 08             	mov    0x8(%ebp),%edx
 84b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 84e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 851:	83 c0 08             	add    $0x8,%eax
 854:	83 ec 0c             	sub    $0xc,%esp
 857:	50                   	push   %eax
 858:	e8 c8 fe ff ff       	call   725 <free>
 85d:	83 c4 10             	add    $0x10,%esp
  return freep;
 860:	a1 1c 0c 00 00       	mov    0xc1c,%eax
}
 865:	c9                   	leave  
 866:	c3                   	ret    

00000867 <malloc>:

void*
malloc(uint nbytes)
{
 867:	55                   	push   %ebp
 868:	89 e5                	mov    %esp,%ebp
 86a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 86d:	8b 45 08             	mov    0x8(%ebp),%eax
 870:	83 c0 07             	add    $0x7,%eax
 873:	c1 e8 03             	shr    $0x3,%eax
 876:	83 c0 01             	add    $0x1,%eax
 879:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 87c:	a1 1c 0c 00 00       	mov    0xc1c,%eax
 881:	89 45 f0             	mov    %eax,-0x10(%ebp)
 884:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 888:	75 23                	jne    8ad <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 88a:	c7 45 f0 14 0c 00 00 	movl   $0xc14,-0x10(%ebp)
 891:	8b 45 f0             	mov    -0x10(%ebp),%eax
 894:	a3 1c 0c 00 00       	mov    %eax,0xc1c
 899:	a1 1c 0c 00 00       	mov    0xc1c,%eax
 89e:	a3 14 0c 00 00       	mov    %eax,0xc14
    base.s.size = 0;
 8a3:	c7 05 18 0c 00 00 00 	movl   $0x0,0xc18
 8aa:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b0:	8b 00                	mov    (%eax),%eax
 8b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b8:	8b 40 04             	mov    0x4(%eax),%eax
 8bb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8be:	72 4d                	jb     90d <malloc+0xa6>
      if(p->s.size == nunits)
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	8b 40 04             	mov    0x4(%eax),%eax
 8c6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8c9:	75 0c                	jne    8d7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ce:	8b 10                	mov    (%eax),%edx
 8d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d3:	89 10                	mov    %edx,(%eax)
 8d5:	eb 26                	jmp    8fd <malloc+0x96>
      else {
        p->s.size -= nunits;
 8d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8da:	8b 40 04             	mov    0x4(%eax),%eax
 8dd:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8e0:	89 c2                	mov    %eax,%edx
 8e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8eb:	8b 40 04             	mov    0x4(%eax),%eax
 8ee:	c1 e0 03             	shl    $0x3,%eax
 8f1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8fa:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 900:	a3 1c 0c 00 00       	mov    %eax,0xc1c
      return (void*)(p + 1);
 905:	8b 45 f4             	mov    -0xc(%ebp),%eax
 908:	83 c0 08             	add    $0x8,%eax
 90b:	eb 3b                	jmp    948 <malloc+0xe1>
    }
    if(p == freep)
 90d:	a1 1c 0c 00 00       	mov    0xc1c,%eax
 912:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 915:	75 1e                	jne    935 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 917:	83 ec 0c             	sub    $0xc,%esp
 91a:	ff 75 ec             	pushl  -0x14(%ebp)
 91d:	e8 e5 fe ff ff       	call   807 <morecore>
 922:	83 c4 10             	add    $0x10,%esp
 925:	89 45 f4             	mov    %eax,-0xc(%ebp)
 928:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 92c:	75 07                	jne    935 <malloc+0xce>
        return 0;
 92e:	b8 00 00 00 00       	mov    $0x0,%eax
 933:	eb 13                	jmp    948 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 935:	8b 45 f4             	mov    -0xc(%ebp),%eax
 938:	89 45 f0             	mov    %eax,-0x10(%ebp)
 93b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93e:	8b 00                	mov    (%eax),%eax
 940:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 943:	e9 6d ff ff ff       	jmp    8b5 <malloc+0x4e>
}
 948:	c9                   	leave  
 949:	c3                   	ret    
