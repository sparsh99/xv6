
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
   d:	e9 b8 00 00 00       	jmp    ca <grep+0xca>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1b:	05 00 0e 00 00       	add    $0xe00,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 00 0e 00 00 	movl   $0xe00,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  2a:	eb 4a                	jmp    76 <grep+0x76>
      *q = 0;
  2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  32:	83 ec 08             	sub    $0x8,%esp
  35:	ff 75 f0             	pushl  -0x10(%ebp)
  38:	ff 75 08             	pushl  0x8(%ebp)
  3b:	e8 9c 01 00 00       	call   1dc <match>
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 c0                	test   %eax,%eax
  45:	74 26                	je     6d <grep+0x6d>
        *q = '\n';
  47:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4a:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  50:	83 c0 01             	add    $0x1,%eax
  53:	89 c2                	mov    %eax,%edx
  55:	8b 45 f0             	mov    -0x10(%ebp),%eax
  58:	29 c2                	sub    %eax,%edx
  5a:	89 d0                	mov    %edx,%eax
  5c:	83 ec 04             	sub    $0x4,%esp
  5f:	50                   	push   %eax
  60:	ff 75 f0             	pushl  -0x10(%ebp)
  63:	6a 01                	push   $0x1
  65:	e8 45 05 00 00       	call   5af <write>
  6a:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  6d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  70:	83 c0 01             	add    $0x1,%eax
  73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  76:	83 ec 08             	sub    $0x8,%esp
  79:	6a 0a                	push   $0xa
  7b:	ff 75 f0             	pushl  -0x10(%ebp)
  7e:	e8 8b 03 00 00       	call   40e <strchr>
  83:	83 c4 10             	add    $0x10,%esp
  86:	89 45 e8             	mov    %eax,-0x18(%ebp)
  89:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8d:	75 9d                	jne    2c <grep+0x2c>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  8f:	81 7d f0 00 0e 00 00 	cmpl   $0xe00,-0x10(%ebp)
  96:	75 07                	jne    9f <grep+0x9f>
      m = 0;
  98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a3:	7e 25                	jle    ca <grep+0xca>
      m -= p - buf;
  a5:	ba 00 0e 00 00       	mov    $0xe00,%edx
  aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ad:	29 c2                	sub    %eax,%edx
  af:	89 d0                	mov    %edx,%eax
  b1:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  b4:	83 ec 04             	sub    $0x4,%esp
  b7:	ff 75 f4             	pushl  -0xc(%ebp)
  ba:	ff 75 f0             	pushl  -0x10(%ebp)
  bd:	68 00 0e 00 00       	push   $0xe00
  c2:	e8 83 04 00 00       	call   54a <memmove>
  c7:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  cd:	ba ff 03 00 00       	mov    $0x3ff,%edx
  d2:	29 c2                	sub    %eax,%edx
  d4:	89 d0                	mov    %edx,%eax
  d6:	89 c2                	mov    %eax,%edx
  d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  db:	05 00 0e 00 00       	add    $0xe00,%eax
  e0:	83 ec 04             	sub    $0x4,%esp
  e3:	52                   	push   %edx
  e4:	50                   	push   %eax
  e5:	ff 75 0c             	pushl  0xc(%ebp)
  e8:	e8 ba 04 00 00       	call   5a7 <read>
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  f7:	0f 8f 15 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
  fd:	90                   	nop
  fe:	c9                   	leave  
  ff:	c3                   	ret    

00000100 <main>:

int
main(int argc, char *argv[])
{
 100:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 104:	83 e4 f0             	and    $0xfffffff0,%esp
 107:	ff 71 fc             	pushl  -0x4(%ecx)
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	53                   	push   %ebx
 10e:	51                   	push   %ecx
 10f:	83 ec 10             	sub    $0x10,%esp
 112:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 114:	83 3b 01             	cmpl   $0x1,(%ebx)
 117:	7f 17                	jg     130 <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
 119:	83 ec 08             	sub    $0x8,%esp
 11c:	68 bc 0a 00 00       	push   $0xabc
 121:	6a 02                	push   $0x2
 123:	e8 de 05 00 00       	call   706 <printf>
 128:	83 c4 10             	add    $0x10,%esp
    exit();
 12b:	e8 5f 04 00 00       	call   58f <exit>
  }
  pattern = argv[1];
 130:	8b 43 04             	mov    0x4(%ebx),%eax
 133:	8b 40 04             	mov    0x4(%eax),%eax
 136:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
 139:	83 3b 02             	cmpl   $0x2,(%ebx)
 13c:	7f 15                	jg     153 <main+0x53>
    grep(pattern, 0);
 13e:	83 ec 08             	sub    $0x8,%esp
 141:	6a 00                	push   $0x0
 143:	ff 75 f0             	pushl  -0x10(%ebp)
 146:	e8 b5 fe ff ff       	call   0 <grep>
 14b:	83 c4 10             	add    $0x10,%esp
    exit();
 14e:	e8 3c 04 00 00       	call   58f <exit>
  }

  for(i = 2; i < argc; i++){
 153:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 15a:	eb 74                	jmp    1d0 <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
 15c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 166:	8b 43 04             	mov    0x4(%ebx),%eax
 169:	01 d0                	add    %edx,%eax
 16b:	8b 00                	mov    (%eax),%eax
 16d:	83 ec 08             	sub    $0x8,%esp
 170:	6a 00                	push   $0x0
 172:	50                   	push   %eax
 173:	e8 57 04 00 00       	call   5cf <open>
 178:	83 c4 10             	add    $0x10,%esp
 17b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 17e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 182:	79 29                	jns    1ad <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
 184:	8b 45 f4             	mov    -0xc(%ebp),%eax
 187:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 18e:	8b 43 04             	mov    0x4(%ebx),%eax
 191:	01 d0                	add    %edx,%eax
 193:	8b 00                	mov    (%eax),%eax
 195:	83 ec 04             	sub    $0x4,%esp
 198:	50                   	push   %eax
 199:	68 dc 0a 00 00       	push   $0xadc
 19e:	6a 01                	push   $0x1
 1a0:	e8 61 05 00 00       	call   706 <printf>
 1a5:	83 c4 10             	add    $0x10,%esp
      exit();
 1a8:	e8 e2 03 00 00       	call   58f <exit>
    }
    grep(pattern, fd);
 1ad:	83 ec 08             	sub    $0x8,%esp
 1b0:	ff 75 ec             	pushl  -0x14(%ebp)
 1b3:	ff 75 f0             	pushl  -0x10(%ebp)
 1b6:	e8 45 fe ff ff       	call   0 <grep>
 1bb:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1be:	83 ec 0c             	sub    $0xc,%esp
 1c1:	ff 75 ec             	pushl  -0x14(%ebp)
 1c4:	e8 ee 03 00 00       	call   5b7 <close>
 1c9:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1cc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d3:	3b 03                	cmp    (%ebx),%eax
 1d5:	7c 85                	jl     15c <main+0x5c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1d7:	e8 b3 03 00 00       	call   58f <exit>

000001dc <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	0f b6 00             	movzbl (%eax),%eax
 1e8:	3c 5e                	cmp    $0x5e,%al
 1ea:	75 17                	jne    203 <match+0x27>
    return matchhere(re+1, text);
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	83 c0 01             	add    $0x1,%eax
 1f2:	83 ec 08             	sub    $0x8,%esp
 1f5:	ff 75 0c             	pushl  0xc(%ebp)
 1f8:	50                   	push   %eax
 1f9:	e8 38 00 00 00       	call   236 <matchhere>
 1fe:	83 c4 10             	add    $0x10,%esp
 201:	eb 31                	jmp    234 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
 203:	83 ec 08             	sub    $0x8,%esp
 206:	ff 75 0c             	pushl  0xc(%ebp)
 209:	ff 75 08             	pushl  0x8(%ebp)
 20c:	e8 25 00 00 00       	call   236 <matchhere>
 211:	83 c4 10             	add    $0x10,%esp
 214:	85 c0                	test   %eax,%eax
 216:	74 07                	je     21f <match+0x43>
      return 1;
 218:	b8 01 00 00 00       	mov    $0x1,%eax
 21d:	eb 15                	jmp    234 <match+0x58>
  }while(*text++ != '\0');
 21f:	8b 45 0c             	mov    0xc(%ebp),%eax
 222:	8d 50 01             	lea    0x1(%eax),%edx
 225:	89 55 0c             	mov    %edx,0xc(%ebp)
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	84 c0                	test   %al,%al
 22d:	75 d4                	jne    203 <match+0x27>
  return 0;
 22f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 234:	c9                   	leave  
 235:	c3                   	ret    

00000236 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 236:	55                   	push   %ebp
 237:	89 e5                	mov    %esp,%ebp
 239:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 23c:	8b 45 08             	mov    0x8(%ebp),%eax
 23f:	0f b6 00             	movzbl (%eax),%eax
 242:	84 c0                	test   %al,%al
 244:	75 0a                	jne    250 <matchhere+0x1a>
    return 1;
 246:	b8 01 00 00 00       	mov    $0x1,%eax
 24b:	e9 99 00 00 00       	jmp    2e9 <matchhere+0xb3>
  if(re[1] == '*')
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	83 c0 01             	add    $0x1,%eax
 256:	0f b6 00             	movzbl (%eax),%eax
 259:	3c 2a                	cmp    $0x2a,%al
 25b:	75 21                	jne    27e <matchhere+0x48>
    return matchstar(re[0], re+2, text);
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
 260:	8d 50 02             	lea    0x2(%eax),%edx
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 00             	movzbl (%eax),%eax
 269:	0f be c0             	movsbl %al,%eax
 26c:	83 ec 04             	sub    $0x4,%esp
 26f:	ff 75 0c             	pushl  0xc(%ebp)
 272:	52                   	push   %edx
 273:	50                   	push   %eax
 274:	e8 72 00 00 00       	call   2eb <matchstar>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	eb 6b                	jmp    2e9 <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	0f b6 00             	movzbl (%eax),%eax
 284:	3c 24                	cmp    $0x24,%al
 286:	75 1d                	jne    2a5 <matchhere+0x6f>
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	83 c0 01             	add    $0x1,%eax
 28e:	0f b6 00             	movzbl (%eax),%eax
 291:	84 c0                	test   %al,%al
 293:	75 10                	jne    2a5 <matchhere+0x6f>
    return *text == '\0';
 295:	8b 45 0c             	mov    0xc(%ebp),%eax
 298:	0f b6 00             	movzbl (%eax),%eax
 29b:	84 c0                	test   %al,%al
 29d:	0f 94 c0             	sete   %al
 2a0:	0f b6 c0             	movzbl %al,%eax
 2a3:	eb 44                	jmp    2e9 <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a8:	0f b6 00             	movzbl (%eax),%eax
 2ab:	84 c0                	test   %al,%al
 2ad:	74 35                	je     2e4 <matchhere+0xae>
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
 2b2:	0f b6 00             	movzbl (%eax),%eax
 2b5:	3c 2e                	cmp    $0x2e,%al
 2b7:	74 10                	je     2c9 <matchhere+0x93>
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 10             	movzbl (%eax),%edx
 2bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c2:	0f b6 00             	movzbl (%eax),%eax
 2c5:	38 c2                	cmp    %al,%dl
 2c7:	75 1b                	jne    2e4 <matchhere+0xae>
    return matchhere(re+1, text+1);
 2c9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cc:	8d 50 01             	lea    0x1(%eax),%edx
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
 2d2:	83 c0 01             	add    $0x1,%eax
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	52                   	push   %edx
 2d9:	50                   	push   %eax
 2da:	e8 57 ff ff ff       	call   236 <matchhere>
 2df:	83 c4 10             	add    $0x10,%esp
 2e2:	eb 05                	jmp    2e9 <matchhere+0xb3>
  return 0;
 2e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2e9:	c9                   	leave  
 2ea:	c3                   	ret    

000002eb <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2eb:	55                   	push   %ebp
 2ec:	89 e5                	mov    %esp,%ebp
 2ee:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2f1:	83 ec 08             	sub    $0x8,%esp
 2f4:	ff 75 10             	pushl  0x10(%ebp)
 2f7:	ff 75 0c             	pushl  0xc(%ebp)
 2fa:	e8 37 ff ff ff       	call   236 <matchhere>
 2ff:	83 c4 10             	add    $0x10,%esp
 302:	85 c0                	test   %eax,%eax
 304:	74 07                	je     30d <matchstar+0x22>
      return 1;
 306:	b8 01 00 00 00       	mov    $0x1,%eax
 30b:	eb 29                	jmp    336 <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
 30d:	8b 45 10             	mov    0x10(%ebp),%eax
 310:	0f b6 00             	movzbl (%eax),%eax
 313:	84 c0                	test   %al,%al
 315:	74 1a                	je     331 <matchstar+0x46>
 317:	8b 45 10             	mov    0x10(%ebp),%eax
 31a:	8d 50 01             	lea    0x1(%eax),%edx
 31d:	89 55 10             	mov    %edx,0x10(%ebp)
 320:	0f b6 00             	movzbl (%eax),%eax
 323:	0f be c0             	movsbl %al,%eax
 326:	3b 45 08             	cmp    0x8(%ebp),%eax
 329:	74 c6                	je     2f1 <matchstar+0x6>
 32b:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 32f:	74 c0                	je     2f1 <matchstar+0x6>
  return 0;
 331:	b8 00 00 00 00       	mov    $0x0,%eax
}
 336:	c9                   	leave  
 337:	c3                   	ret    

00000338 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	57                   	push   %edi
 33c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 33d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 340:	8b 55 10             	mov    0x10(%ebp),%edx
 343:	8b 45 0c             	mov    0xc(%ebp),%eax
 346:	89 cb                	mov    %ecx,%ebx
 348:	89 df                	mov    %ebx,%edi
 34a:	89 d1                	mov    %edx,%ecx
 34c:	fc                   	cld    
 34d:	f3 aa                	rep stos %al,%es:(%edi)
 34f:	89 ca                	mov    %ecx,%edx
 351:	89 fb                	mov    %edi,%ebx
 353:	89 5d 08             	mov    %ebx,0x8(%ebp)
 356:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 359:	90                   	nop
 35a:	5b                   	pop    %ebx
 35b:	5f                   	pop    %edi
 35c:	5d                   	pop    %ebp
 35d:	c3                   	ret    

0000035e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 35e:	55                   	push   %ebp
 35f:	89 e5                	mov    %esp,%ebp
 361:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 364:	8b 45 08             	mov    0x8(%ebp),%eax
 367:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 36a:	90                   	nop
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
 36e:	8d 50 01             	lea    0x1(%eax),%edx
 371:	89 55 08             	mov    %edx,0x8(%ebp)
 374:	8b 55 0c             	mov    0xc(%ebp),%edx
 377:	8d 4a 01             	lea    0x1(%edx),%ecx
 37a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 37d:	0f b6 12             	movzbl (%edx),%edx
 380:	88 10                	mov    %dl,(%eax)
 382:	0f b6 00             	movzbl (%eax),%eax
 385:	84 c0                	test   %al,%al
 387:	75 e2                	jne    36b <strcpy+0xd>
    ;
  return os;
 389:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 38c:	c9                   	leave  
 38d:	c3                   	ret    

0000038e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 38e:	55                   	push   %ebp
 38f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 391:	eb 08                	jmp    39b <strcmp+0xd>
    p++, q++;
 393:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 397:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	0f b6 00             	movzbl (%eax),%eax
 3a1:	84 c0                	test   %al,%al
 3a3:	74 10                	je     3b5 <strcmp+0x27>
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
 3a8:	0f b6 10             	movzbl (%eax),%edx
 3ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ae:	0f b6 00             	movzbl (%eax),%eax
 3b1:	38 c2                	cmp    %al,%dl
 3b3:	74 de                	je     393 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3b5:	8b 45 08             	mov    0x8(%ebp),%eax
 3b8:	0f b6 00             	movzbl (%eax),%eax
 3bb:	0f b6 d0             	movzbl %al,%edx
 3be:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c1:	0f b6 00             	movzbl (%eax),%eax
 3c4:	0f b6 c0             	movzbl %al,%eax
 3c7:	29 c2                	sub    %eax,%edx
 3c9:	89 d0                	mov    %edx,%eax
}
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    

000003cd <strlen>:

uint
strlen(char *s)
{
 3cd:	55                   	push   %ebp
 3ce:	89 e5                	mov    %esp,%ebp
 3d0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3da:	eb 04                	jmp    3e0 <strlen+0x13>
 3dc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	01 d0                	add    %edx,%eax
 3e8:	0f b6 00             	movzbl (%eax),%eax
 3eb:	84 c0                	test   %al,%al
 3ed:	75 ed                	jne    3dc <strlen+0xf>
    ;
  return n;
 3ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3f2:	c9                   	leave  
 3f3:	c3                   	ret    

000003f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3f7:	8b 45 10             	mov    0x10(%ebp),%eax
 3fa:	50                   	push   %eax
 3fb:	ff 75 0c             	pushl  0xc(%ebp)
 3fe:	ff 75 08             	pushl  0x8(%ebp)
 401:	e8 32 ff ff ff       	call   338 <stosb>
 406:	83 c4 0c             	add    $0xc,%esp
  return dst;
 409:	8b 45 08             	mov    0x8(%ebp),%eax
}
 40c:	c9                   	leave  
 40d:	c3                   	ret    

0000040e <strchr>:

char*
strchr(const char *s, char c)
{
 40e:	55                   	push   %ebp
 40f:	89 e5                	mov    %esp,%ebp
 411:	83 ec 04             	sub    $0x4,%esp
 414:	8b 45 0c             	mov    0xc(%ebp),%eax
 417:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 41a:	eb 14                	jmp    430 <strchr+0x22>
    if(*s == c)
 41c:	8b 45 08             	mov    0x8(%ebp),%eax
 41f:	0f b6 00             	movzbl (%eax),%eax
 422:	3a 45 fc             	cmp    -0x4(%ebp),%al
 425:	75 05                	jne    42c <strchr+0x1e>
      return (char*)s;
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	eb 13                	jmp    43f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 42c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 430:	8b 45 08             	mov    0x8(%ebp),%eax
 433:	0f b6 00             	movzbl (%eax),%eax
 436:	84 c0                	test   %al,%al
 438:	75 e2                	jne    41c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 43a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 43f:	c9                   	leave  
 440:	c3                   	ret    

00000441 <gets>:

char*
gets(char *buf, int max)
{
 441:	55                   	push   %ebp
 442:	89 e5                	mov    %esp,%ebp
 444:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 447:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 44e:	eb 42                	jmp    492 <gets+0x51>
    cc = read(0, &c, 1);
 450:	83 ec 04             	sub    $0x4,%esp
 453:	6a 01                	push   $0x1
 455:	8d 45 ef             	lea    -0x11(%ebp),%eax
 458:	50                   	push   %eax
 459:	6a 00                	push   $0x0
 45b:	e8 47 01 00 00       	call   5a7 <read>
 460:	83 c4 10             	add    $0x10,%esp
 463:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 466:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46a:	7e 33                	jle    49f <gets+0x5e>
      break;
    buf[i++] = c;
 46c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46f:	8d 50 01             	lea    0x1(%eax),%edx
 472:	89 55 f4             	mov    %edx,-0xc(%ebp)
 475:	89 c2                	mov    %eax,%edx
 477:	8b 45 08             	mov    0x8(%ebp),%eax
 47a:	01 c2                	add    %eax,%edx
 47c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 480:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 482:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 486:	3c 0a                	cmp    $0xa,%al
 488:	74 16                	je     4a0 <gets+0x5f>
 48a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 48e:	3c 0d                	cmp    $0xd,%al
 490:	74 0e                	je     4a0 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 492:	8b 45 f4             	mov    -0xc(%ebp),%eax
 495:	83 c0 01             	add    $0x1,%eax
 498:	3b 45 0c             	cmp    0xc(%ebp),%eax
 49b:	7c b3                	jl     450 <gets+0xf>
 49d:	eb 01                	jmp    4a0 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 49f:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	01 d0                	add    %edx,%eax
 4a8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4ae:	c9                   	leave  
 4af:	c3                   	ret    

000004b0 <stat>:

int
stat(char *n, struct stat *st)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b6:	83 ec 08             	sub    $0x8,%esp
 4b9:	6a 00                	push   $0x0
 4bb:	ff 75 08             	pushl  0x8(%ebp)
 4be:	e8 0c 01 00 00       	call   5cf <open>
 4c3:	83 c4 10             	add    $0x10,%esp
 4c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4cd:	79 07                	jns    4d6 <stat+0x26>
    return -1;
 4cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4d4:	eb 25                	jmp    4fb <stat+0x4b>
  r = fstat(fd, st);
 4d6:	83 ec 08             	sub    $0x8,%esp
 4d9:	ff 75 0c             	pushl  0xc(%ebp)
 4dc:	ff 75 f4             	pushl  -0xc(%ebp)
 4df:	e8 03 01 00 00       	call   5e7 <fstat>
 4e4:	83 c4 10             	add    $0x10,%esp
 4e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4ea:	83 ec 0c             	sub    $0xc,%esp
 4ed:	ff 75 f4             	pushl  -0xc(%ebp)
 4f0:	e8 c2 00 00 00       	call   5b7 <close>
 4f5:	83 c4 10             	add    $0x10,%esp
  return r;
 4f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4fb:	c9                   	leave  
 4fc:	c3                   	ret    

000004fd <atoi>:

int
atoi(const char *s)
{
 4fd:	55                   	push   %ebp
 4fe:	89 e5                	mov    %esp,%ebp
 500:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 503:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 50a:	eb 25                	jmp    531 <atoi+0x34>
    n = n*10 + *s++ - '0';
 50c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 50f:	89 d0                	mov    %edx,%eax
 511:	c1 e0 02             	shl    $0x2,%eax
 514:	01 d0                	add    %edx,%eax
 516:	01 c0                	add    %eax,%eax
 518:	89 c1                	mov    %eax,%ecx
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	8d 50 01             	lea    0x1(%eax),%edx
 520:	89 55 08             	mov    %edx,0x8(%ebp)
 523:	0f b6 00             	movzbl (%eax),%eax
 526:	0f be c0             	movsbl %al,%eax
 529:	01 c8                	add    %ecx,%eax
 52b:	83 e8 30             	sub    $0x30,%eax
 52e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 531:	8b 45 08             	mov    0x8(%ebp),%eax
 534:	0f b6 00             	movzbl (%eax),%eax
 537:	3c 2f                	cmp    $0x2f,%al
 539:	7e 0a                	jle    545 <atoi+0x48>
 53b:	8b 45 08             	mov    0x8(%ebp),%eax
 53e:	0f b6 00             	movzbl (%eax),%eax
 541:	3c 39                	cmp    $0x39,%al
 543:	7e c7                	jle    50c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 545:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 548:	c9                   	leave  
 549:	c3                   	ret    

0000054a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 54a:	55                   	push   %ebp
 54b:	89 e5                	mov    %esp,%ebp
 54d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 550:	8b 45 08             	mov    0x8(%ebp),%eax
 553:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 556:	8b 45 0c             	mov    0xc(%ebp),%eax
 559:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 55c:	eb 17                	jmp    575 <memmove+0x2b>
    *dst++ = *src++;
 55e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 561:	8d 50 01             	lea    0x1(%eax),%edx
 564:	89 55 fc             	mov    %edx,-0x4(%ebp)
 567:	8b 55 f8             	mov    -0x8(%ebp),%edx
 56a:	8d 4a 01             	lea    0x1(%edx),%ecx
 56d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 570:	0f b6 12             	movzbl (%edx),%edx
 573:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 575:	8b 45 10             	mov    0x10(%ebp),%eax
 578:	8d 50 ff             	lea    -0x1(%eax),%edx
 57b:	89 55 10             	mov    %edx,0x10(%ebp)
 57e:	85 c0                	test   %eax,%eax
 580:	7f dc                	jg     55e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 582:	8b 45 08             	mov    0x8(%ebp),%eax
}
 585:	c9                   	leave  
 586:	c3                   	ret    

00000587 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 587:	b8 01 00 00 00       	mov    $0x1,%eax
 58c:	cd 40                	int    $0x40
 58e:	c3                   	ret    

0000058f <exit>:
SYSCALL(exit)
 58f:	b8 02 00 00 00       	mov    $0x2,%eax
 594:	cd 40                	int    $0x40
 596:	c3                   	ret    

00000597 <wait>:
SYSCALL(wait)
 597:	b8 03 00 00 00       	mov    $0x3,%eax
 59c:	cd 40                	int    $0x40
 59e:	c3                   	ret    

0000059f <pipe>:
SYSCALL(pipe)
 59f:	b8 04 00 00 00       	mov    $0x4,%eax
 5a4:	cd 40                	int    $0x40
 5a6:	c3                   	ret    

000005a7 <read>:
SYSCALL(read)
 5a7:	b8 05 00 00 00       	mov    $0x5,%eax
 5ac:	cd 40                	int    $0x40
 5ae:	c3                   	ret    

000005af <write>:
SYSCALL(write)
 5af:	b8 10 00 00 00       	mov    $0x10,%eax
 5b4:	cd 40                	int    $0x40
 5b6:	c3                   	ret    

000005b7 <close>:
SYSCALL(close)
 5b7:	b8 15 00 00 00       	mov    $0x15,%eax
 5bc:	cd 40                	int    $0x40
 5be:	c3                   	ret    

000005bf <kill>:
SYSCALL(kill)
 5bf:	b8 06 00 00 00       	mov    $0x6,%eax
 5c4:	cd 40                	int    $0x40
 5c6:	c3                   	ret    

000005c7 <exec>:
SYSCALL(exec)
 5c7:	b8 07 00 00 00       	mov    $0x7,%eax
 5cc:	cd 40                	int    $0x40
 5ce:	c3                   	ret    

000005cf <open>:
SYSCALL(open)
 5cf:	b8 0f 00 00 00       	mov    $0xf,%eax
 5d4:	cd 40                	int    $0x40
 5d6:	c3                   	ret    

000005d7 <mknod>:
SYSCALL(mknod)
 5d7:	b8 11 00 00 00       	mov    $0x11,%eax
 5dc:	cd 40                	int    $0x40
 5de:	c3                   	ret    

000005df <unlink>:
SYSCALL(unlink)
 5df:	b8 12 00 00 00       	mov    $0x12,%eax
 5e4:	cd 40                	int    $0x40
 5e6:	c3                   	ret    

000005e7 <fstat>:
SYSCALL(fstat)
 5e7:	b8 08 00 00 00       	mov    $0x8,%eax
 5ec:	cd 40                	int    $0x40
 5ee:	c3                   	ret    

000005ef <link>:
SYSCALL(link)
 5ef:	b8 13 00 00 00       	mov    $0x13,%eax
 5f4:	cd 40                	int    $0x40
 5f6:	c3                   	ret    

000005f7 <mkdir>:
SYSCALL(mkdir)
 5f7:	b8 14 00 00 00       	mov    $0x14,%eax
 5fc:	cd 40                	int    $0x40
 5fe:	c3                   	ret    

000005ff <chdir>:
SYSCALL(chdir)
 5ff:	b8 09 00 00 00       	mov    $0x9,%eax
 604:	cd 40                	int    $0x40
 606:	c3                   	ret    

00000607 <dup>:
SYSCALL(dup)
 607:	b8 0a 00 00 00       	mov    $0xa,%eax
 60c:	cd 40                	int    $0x40
 60e:	c3                   	ret    

0000060f <getpid>:
SYSCALL(getpid)
 60f:	b8 0b 00 00 00       	mov    $0xb,%eax
 614:	cd 40                	int    $0x40
 616:	c3                   	ret    

00000617 <sbrk>:
SYSCALL(sbrk)
 617:	b8 0c 00 00 00       	mov    $0xc,%eax
 61c:	cd 40                	int    $0x40
 61e:	c3                   	ret    

0000061f <sleep>:
SYSCALL(sleep)
 61f:	b8 0d 00 00 00       	mov    $0xd,%eax
 624:	cd 40                	int    $0x40
 626:	c3                   	ret    

00000627 <uptime>:
SYSCALL(uptime)
 627:	b8 0e 00 00 00       	mov    $0xe,%eax
 62c:	cd 40                	int    $0x40
 62e:	c3                   	ret    

0000062f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 62f:	55                   	push   %ebp
 630:	89 e5                	mov    %esp,%ebp
 632:	83 ec 18             	sub    $0x18,%esp
 635:	8b 45 0c             	mov    0xc(%ebp),%eax
 638:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 63b:	83 ec 04             	sub    $0x4,%esp
 63e:	6a 01                	push   $0x1
 640:	8d 45 f4             	lea    -0xc(%ebp),%eax
 643:	50                   	push   %eax
 644:	ff 75 08             	pushl  0x8(%ebp)
 647:	e8 63 ff ff ff       	call   5af <write>
 64c:	83 c4 10             	add    $0x10,%esp
}
 64f:	90                   	nop
 650:	c9                   	leave  
 651:	c3                   	ret    

00000652 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 652:	55                   	push   %ebp
 653:	89 e5                	mov    %esp,%ebp
 655:	53                   	push   %ebx
 656:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 659:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 660:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 664:	74 17                	je     67d <printint+0x2b>
 666:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 66a:	79 11                	jns    67d <printint+0x2b>
    neg = 1;
 66c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 673:	8b 45 0c             	mov    0xc(%ebp),%eax
 676:	f7 d8                	neg    %eax
 678:	89 45 ec             	mov    %eax,-0x14(%ebp)
 67b:	eb 06                	jmp    683 <printint+0x31>
  } else {
    x = xx;
 67d:	8b 45 0c             	mov    0xc(%ebp),%eax
 680:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 683:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 68a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 68d:	8d 41 01             	lea    0x1(%ecx),%eax
 690:	89 45 f4             	mov    %eax,-0xc(%ebp)
 693:	8b 5d 10             	mov    0x10(%ebp),%ebx
 696:	8b 45 ec             	mov    -0x14(%ebp),%eax
 699:	ba 00 00 00 00       	mov    $0x0,%edx
 69e:	f7 f3                	div    %ebx
 6a0:	89 d0                	mov    %edx,%eax
 6a2:	0f b6 80 c8 0d 00 00 	movzbl 0xdc8(%eax),%eax
 6a9:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 6ad:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6b3:	ba 00 00 00 00       	mov    $0x0,%edx
 6b8:	f7 f3                	div    %ebx
 6ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6c1:	75 c7                	jne    68a <printint+0x38>
  if(neg)
 6c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6c7:	74 2d                	je     6f6 <printint+0xa4>
    buf[i++] = '-';
 6c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6cc:	8d 50 01             	lea    0x1(%eax),%edx
 6cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6d2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6d7:	eb 1d                	jmp    6f6 <printint+0xa4>
    putc(fd, buf[i]);
 6d9:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6df:	01 d0                	add    %edx,%eax
 6e1:	0f b6 00             	movzbl (%eax),%eax
 6e4:	0f be c0             	movsbl %al,%eax
 6e7:	83 ec 08             	sub    $0x8,%esp
 6ea:	50                   	push   %eax
 6eb:	ff 75 08             	pushl  0x8(%ebp)
 6ee:	e8 3c ff ff ff       	call   62f <putc>
 6f3:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6f6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 6fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6fe:	79 d9                	jns    6d9 <printint+0x87>
    putc(fd, buf[i]);
}
 700:	90                   	nop
 701:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 704:	c9                   	leave  
 705:	c3                   	ret    

00000706 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 706:	55                   	push   %ebp
 707:	89 e5                	mov    %esp,%ebp
 709:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 70c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 713:	8d 45 0c             	lea    0xc(%ebp),%eax
 716:	83 c0 04             	add    $0x4,%eax
 719:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 71c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 723:	e9 59 01 00 00       	jmp    881 <printf+0x17b>
    c = fmt[i] & 0xff;
 728:	8b 55 0c             	mov    0xc(%ebp),%edx
 72b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72e:	01 d0                	add    %edx,%eax
 730:	0f b6 00             	movzbl (%eax),%eax
 733:	0f be c0             	movsbl %al,%eax
 736:	25 ff 00 00 00       	and    $0xff,%eax
 73b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 73e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 742:	75 2c                	jne    770 <printf+0x6a>
      if(c == '%'){
 744:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 748:	75 0c                	jne    756 <printf+0x50>
        state = '%';
 74a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 751:	e9 27 01 00 00       	jmp    87d <printf+0x177>
      } else {
        putc(fd, c);
 756:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 759:	0f be c0             	movsbl %al,%eax
 75c:	83 ec 08             	sub    $0x8,%esp
 75f:	50                   	push   %eax
 760:	ff 75 08             	pushl  0x8(%ebp)
 763:	e8 c7 fe ff ff       	call   62f <putc>
 768:	83 c4 10             	add    $0x10,%esp
 76b:	e9 0d 01 00 00       	jmp    87d <printf+0x177>
      }
    } else if(state == '%'){
 770:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 774:	0f 85 03 01 00 00    	jne    87d <printf+0x177>
      if(c == 'd'){
 77a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 77e:	75 1e                	jne    79e <printf+0x98>
        printint(fd, *ap, 10, 1);
 780:	8b 45 e8             	mov    -0x18(%ebp),%eax
 783:	8b 00                	mov    (%eax),%eax
 785:	6a 01                	push   $0x1
 787:	6a 0a                	push   $0xa
 789:	50                   	push   %eax
 78a:	ff 75 08             	pushl  0x8(%ebp)
 78d:	e8 c0 fe ff ff       	call   652 <printint>
 792:	83 c4 10             	add    $0x10,%esp
        ap++;
 795:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 799:	e9 d8 00 00 00       	jmp    876 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 79e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7a2:	74 06                	je     7aa <printf+0xa4>
 7a4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7a8:	75 1e                	jne    7c8 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 7aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ad:	8b 00                	mov    (%eax),%eax
 7af:	6a 00                	push   $0x0
 7b1:	6a 10                	push   $0x10
 7b3:	50                   	push   %eax
 7b4:	ff 75 08             	pushl  0x8(%ebp)
 7b7:	e8 96 fe ff ff       	call   652 <printint>
 7bc:	83 c4 10             	add    $0x10,%esp
        ap++;
 7bf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7c3:	e9 ae 00 00 00       	jmp    876 <printf+0x170>
      } else if(c == 's'){
 7c8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7cc:	75 43                	jne    811 <printf+0x10b>
        s = (char*)*ap;
 7ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7de:	75 25                	jne    805 <printf+0xff>
          s = "(null)";
 7e0:	c7 45 f4 f2 0a 00 00 	movl   $0xaf2,-0xc(%ebp)
        while(*s != 0){
 7e7:	eb 1c                	jmp    805 <printf+0xff>
          putc(fd, *s);
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	0f b6 00             	movzbl (%eax),%eax
 7ef:	0f be c0             	movsbl %al,%eax
 7f2:	83 ec 08             	sub    $0x8,%esp
 7f5:	50                   	push   %eax
 7f6:	ff 75 08             	pushl  0x8(%ebp)
 7f9:	e8 31 fe ff ff       	call   62f <putc>
 7fe:	83 c4 10             	add    $0x10,%esp
          s++;
 801:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	0f b6 00             	movzbl (%eax),%eax
 80b:	84 c0                	test   %al,%al
 80d:	75 da                	jne    7e9 <printf+0xe3>
 80f:	eb 65                	jmp    876 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 811:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 815:	75 1d                	jne    834 <printf+0x12e>
        putc(fd, *ap);
 817:	8b 45 e8             	mov    -0x18(%ebp),%eax
 81a:	8b 00                	mov    (%eax),%eax
 81c:	0f be c0             	movsbl %al,%eax
 81f:	83 ec 08             	sub    $0x8,%esp
 822:	50                   	push   %eax
 823:	ff 75 08             	pushl  0x8(%ebp)
 826:	e8 04 fe ff ff       	call   62f <putc>
 82b:	83 c4 10             	add    $0x10,%esp
        ap++;
 82e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 832:	eb 42                	jmp    876 <printf+0x170>
      } else if(c == '%'){
 834:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 838:	75 17                	jne    851 <printf+0x14b>
        putc(fd, c);
 83a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 83d:	0f be c0             	movsbl %al,%eax
 840:	83 ec 08             	sub    $0x8,%esp
 843:	50                   	push   %eax
 844:	ff 75 08             	pushl  0x8(%ebp)
 847:	e8 e3 fd ff ff       	call   62f <putc>
 84c:	83 c4 10             	add    $0x10,%esp
 84f:	eb 25                	jmp    876 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 851:	83 ec 08             	sub    $0x8,%esp
 854:	6a 25                	push   $0x25
 856:	ff 75 08             	pushl  0x8(%ebp)
 859:	e8 d1 fd ff ff       	call   62f <putc>
 85e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 861:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 864:	0f be c0             	movsbl %al,%eax
 867:	83 ec 08             	sub    $0x8,%esp
 86a:	50                   	push   %eax
 86b:	ff 75 08             	pushl  0x8(%ebp)
 86e:	e8 bc fd ff ff       	call   62f <putc>
 873:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 876:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 87d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 881:	8b 55 0c             	mov    0xc(%ebp),%edx
 884:	8b 45 f0             	mov    -0x10(%ebp),%eax
 887:	01 d0                	add    %edx,%eax
 889:	0f b6 00             	movzbl (%eax),%eax
 88c:	84 c0                	test   %al,%al
 88e:	0f 85 94 fe ff ff    	jne    728 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 894:	90                   	nop
 895:	c9                   	leave  
 896:	c3                   	ret    

00000897 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 897:	55                   	push   %ebp
 898:	89 e5                	mov    %esp,%ebp
 89a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 89d:	8b 45 08             	mov    0x8(%ebp),%eax
 8a0:	83 e8 08             	sub    $0x8,%eax
 8a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a6:	a1 e8 0d 00 00       	mov    0xde8,%eax
 8ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8ae:	eb 24                	jmp    8d4 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b3:	8b 00                	mov    (%eax),%eax
 8b5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8b8:	77 12                	ja     8cc <free+0x35>
 8ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8bd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8c0:	77 24                	ja     8e6 <free+0x4f>
 8c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c5:	8b 00                	mov    (%eax),%eax
 8c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ca:	77 1a                	ja     8e6 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8cf:	8b 00                	mov    (%eax),%eax
 8d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8da:	76 d4                	jbe    8b0 <free+0x19>
 8dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8df:	8b 00                	mov    (%eax),%eax
 8e1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8e4:	76 ca                	jbe    8b0 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e9:	8b 40 04             	mov    0x4(%eax),%eax
 8ec:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f6:	01 c2                	add    %eax,%edx
 8f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fb:	8b 00                	mov    (%eax),%eax
 8fd:	39 c2                	cmp    %eax,%edx
 8ff:	75 24                	jne    925 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 901:	8b 45 f8             	mov    -0x8(%ebp),%eax
 904:	8b 50 04             	mov    0x4(%eax),%edx
 907:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90a:	8b 00                	mov    (%eax),%eax
 90c:	8b 40 04             	mov    0x4(%eax),%eax
 90f:	01 c2                	add    %eax,%edx
 911:	8b 45 f8             	mov    -0x8(%ebp),%eax
 914:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 917:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91a:	8b 00                	mov    (%eax),%eax
 91c:	8b 10                	mov    (%eax),%edx
 91e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 921:	89 10                	mov    %edx,(%eax)
 923:	eb 0a                	jmp    92f <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 925:	8b 45 fc             	mov    -0x4(%ebp),%eax
 928:	8b 10                	mov    (%eax),%edx
 92a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 92d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 92f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 932:	8b 40 04             	mov    0x4(%eax),%eax
 935:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 93c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93f:	01 d0                	add    %edx,%eax
 941:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 944:	75 20                	jne    966 <free+0xcf>
    p->s.size += bp->s.size;
 946:	8b 45 fc             	mov    -0x4(%ebp),%eax
 949:	8b 50 04             	mov    0x4(%eax),%edx
 94c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 94f:	8b 40 04             	mov    0x4(%eax),%eax
 952:	01 c2                	add    %eax,%edx
 954:	8b 45 fc             	mov    -0x4(%ebp),%eax
 957:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 95a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95d:	8b 10                	mov    (%eax),%edx
 95f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 962:	89 10                	mov    %edx,(%eax)
 964:	eb 08                	jmp    96e <free+0xd7>
  } else
    p->s.ptr = bp;
 966:	8b 45 fc             	mov    -0x4(%ebp),%eax
 969:	8b 55 f8             	mov    -0x8(%ebp),%edx
 96c:	89 10                	mov    %edx,(%eax)
  freep = p;
 96e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 971:	a3 e8 0d 00 00       	mov    %eax,0xde8
}
 976:	90                   	nop
 977:	c9                   	leave  
 978:	c3                   	ret    

00000979 <morecore>:

static Header*
morecore(uint nu)
{
 979:	55                   	push   %ebp
 97a:	89 e5                	mov    %esp,%ebp
 97c:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 97f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 986:	77 07                	ja     98f <morecore+0x16>
    nu = 4096;
 988:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 98f:	8b 45 08             	mov    0x8(%ebp),%eax
 992:	c1 e0 03             	shl    $0x3,%eax
 995:	83 ec 0c             	sub    $0xc,%esp
 998:	50                   	push   %eax
 999:	e8 79 fc ff ff       	call   617 <sbrk>
 99e:	83 c4 10             	add    $0x10,%esp
 9a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9a4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9a8:	75 07                	jne    9b1 <morecore+0x38>
    return 0;
 9aa:	b8 00 00 00 00       	mov    $0x0,%eax
 9af:	eb 26                	jmp    9d7 <morecore+0x5e>
  hp = (Header*)p;
 9b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ba:	8b 55 08             	mov    0x8(%ebp),%edx
 9bd:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c3:	83 c0 08             	add    $0x8,%eax
 9c6:	83 ec 0c             	sub    $0xc,%esp
 9c9:	50                   	push   %eax
 9ca:	e8 c8 fe ff ff       	call   897 <free>
 9cf:	83 c4 10             	add    $0x10,%esp
  return freep;
 9d2:	a1 e8 0d 00 00       	mov    0xde8,%eax
}
 9d7:	c9                   	leave  
 9d8:	c3                   	ret    

000009d9 <malloc>:

void*
malloc(uint nbytes)
{
 9d9:	55                   	push   %ebp
 9da:	89 e5                	mov    %esp,%ebp
 9dc:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9df:	8b 45 08             	mov    0x8(%ebp),%eax
 9e2:	83 c0 07             	add    $0x7,%eax
 9e5:	c1 e8 03             	shr    $0x3,%eax
 9e8:	83 c0 01             	add    $0x1,%eax
 9eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9ee:	a1 e8 0d 00 00       	mov    0xde8,%eax
 9f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9fa:	75 23                	jne    a1f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9fc:	c7 45 f0 e0 0d 00 00 	movl   $0xde0,-0x10(%ebp)
 a03:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a06:	a3 e8 0d 00 00       	mov    %eax,0xde8
 a0b:	a1 e8 0d 00 00       	mov    0xde8,%eax
 a10:	a3 e0 0d 00 00       	mov    %eax,0xde0
    base.s.size = 0;
 a15:	c7 05 e4 0d 00 00 00 	movl   $0x0,0xde4
 a1c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a22:	8b 00                	mov    (%eax),%eax
 a24:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2a:	8b 40 04             	mov    0x4(%eax),%eax
 a2d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a30:	72 4d                	jb     a7f <malloc+0xa6>
      if(p->s.size == nunits)
 a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a35:	8b 40 04             	mov    0x4(%eax),%eax
 a38:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a3b:	75 0c                	jne    a49 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a40:	8b 10                	mov    (%eax),%edx
 a42:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a45:	89 10                	mov    %edx,(%eax)
 a47:	eb 26                	jmp    a6f <malloc+0x96>
      else {
        p->s.size -= nunits;
 a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4c:	8b 40 04             	mov    0x4(%eax),%eax
 a4f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a52:	89 c2                	mov    %eax,%edx
 a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a57:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5d:	8b 40 04             	mov    0x4(%eax),%eax
 a60:	c1 e0 03             	shl    $0x3,%eax
 a63:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a69:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a6c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a72:	a3 e8 0d 00 00       	mov    %eax,0xde8
      return (void*)(p + 1);
 a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a7a:	83 c0 08             	add    $0x8,%eax
 a7d:	eb 3b                	jmp    aba <malloc+0xe1>
    }
    if(p == freep)
 a7f:	a1 e8 0d 00 00       	mov    0xde8,%eax
 a84:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a87:	75 1e                	jne    aa7 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a89:	83 ec 0c             	sub    $0xc,%esp
 a8c:	ff 75 ec             	pushl  -0x14(%ebp)
 a8f:	e8 e5 fe ff ff       	call   979 <morecore>
 a94:	83 c4 10             	add    $0x10,%esp
 a97:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a9a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a9e:	75 07                	jne    aa7 <malloc+0xce>
        return 0;
 aa0:	b8 00 00 00 00       	mov    $0x0,%eax
 aa5:	eb 13                	jmp    aba <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aaa:	89 45 f0             	mov    %eax,-0x10(%ebp)
 aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab0:	8b 00                	mov    (%eax),%eax
 ab2:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 ab5:	e9 6d ff ff ff       	jmp    a27 <malloc+0x4e>
}
 aba:	c9                   	leave  
 abb:	c3                   	ret    
