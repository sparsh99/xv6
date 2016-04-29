
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 9f 11 00 00       	call   11b0 <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 0c 17 00 00 	mov    0x170c(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 e0 16 00 00       	push   $0x16e0
      2c:	e8 ac 04 00 00       	call   4dd <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 67 11 00 00       	call   11b0 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 89 11 00 00       	call   11e8 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 e7 16 00 00       	push   $0x16e7
      71:	6a 02                	push   $0x2
      73:	e8 af 12 00 00       	call   1327 <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 43 11 00 00       	call   11d8 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 42 11 00 00       	call   11f0 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 f7 16 00 00       	push   $0x16f7
      c4:	6a 02                	push   $0x2
      c6:	e8 5c 12 00 00       	call   1327 <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 dd 10 00 00       	call   11b0 <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 08 04 00 00       	call   4fd <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 a8 10 00 00       	call   11b8 <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 87 10 00 00       	call   11c0 <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 07 17 00 00       	push   $0x1707
     148:	e8 90 03 00 00       	call   4dd <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 a8 03 00 00       	call   4fd <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 75 10 00 00       	call   11d8 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 b6 10 00 00       	call   1228 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 57 10 00 00       	call   11d8 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 48 10 00 00       	call   11d8 <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 e8             	mov    -0x18(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 53 03 00 00       	call   4fd <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 20 10 00 00       	call   11d8 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 61 10 00 00       	call   1228 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 02 10 00 00       	call   11d8 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 f3 0f 00 00       	call   11d8 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 d2 0f 00 00       	call   11d8 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 c3 0f 00 00       	call   11d8 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 9b 0f 00 00       	call   11b8 <wait>
    wait();
     21d:	e8 96 0f 00 00       	call   11b8 <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 ce 02 00 00       	call   4fd <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 65 0f 00 00       	call   11b0 <exit>

0000024b <cmdCheck>:
}

int cmdCheck(char *buf){
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 18             	sub    $0x18,%esp
	char hi[]={'h','i','s','t','o','r','y','\0'};
     251:	c6 45 ec 68          	movb   $0x68,-0x14(%ebp)
     255:	c6 45 ed 69          	movb   $0x69,-0x13(%ebp)
     259:	c6 45 ee 73          	movb   $0x73,-0x12(%ebp)
     25d:	c6 45 ef 74          	movb   $0x74,-0x11(%ebp)
     261:	c6 45 f0 6f          	movb   $0x6f,-0x10(%ebp)
     265:	c6 45 f1 72          	movb   $0x72,-0xf(%ebp)
     269:	c6 45 f2 79          	movb   $0x79,-0xe(%ebp)
     26d:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
	int i=0;
     271:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	if(strlen(buf)==0) return 0;
     278:	83 ec 0c             	sub    $0xc,%esp
     27b:	ff 75 08             	pushl  0x8(%ebp)
     27e:	e8 d1 0b 00 00       	call   e54 <strlen>
     283:	83 c4 10             	add    $0x10,%esp
     286:	85 c0                	test   %eax,%eax
     288:	75 07                	jne    291 <cmdCheck+0x46>
     28a:	b8 00 00 00 00       	mov    $0x0,%eax
     28f:	eb 66                	jmp    2f7 <cmdCheck+0xac>
	if(strlen(buf)==1 && buf[0]=='\n') return 0;
     291:	83 ec 0c             	sub    $0xc,%esp
     294:	ff 75 08             	pushl  0x8(%ebp)
     297:	e8 b8 0b 00 00       	call   e54 <strlen>
     29c:	83 c4 10             	add    $0x10,%esp
     29f:	83 f8 01             	cmp    $0x1,%eax
     2a2:	75 36                	jne    2da <cmdCheck+0x8f>
     2a4:	8b 45 08             	mov    0x8(%ebp),%eax
     2a7:	0f b6 00             	movzbl (%eax),%eax
     2aa:	3c 0a                	cmp    $0xa,%al
     2ac:	75 2c                	jne    2da <cmdCheck+0x8f>
     2ae:	b8 00 00 00 00       	mov    $0x0,%eax
     2b3:	eb 42                	jmp    2f7 <cmdCheck+0xac>
	while(i<strlen(hi))
	{	if(buf[i]!=hi[i]) return 1;
     2b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2b8:	8b 45 08             	mov    0x8(%ebp),%eax
     2bb:	01 d0                	add    %edx,%eax
     2bd:	0f b6 10             	movzbl (%eax),%edx
     2c0:	8d 4d ec             	lea    -0x14(%ebp),%ecx
     2c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2c6:	01 c8                	add    %ecx,%eax
     2c8:	0f b6 00             	movzbl (%eax),%eax
     2cb:	38 c2                	cmp    %al,%dl
     2cd:	74 07                	je     2d6 <cmdCheck+0x8b>
     2cf:	b8 01 00 00 00       	mov    $0x1,%eax
     2d4:	eb 21                	jmp    2f7 <cmdCheck+0xac>
		i++;
     2d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
int cmdCheck(char *buf){
	char hi[]={'h','i','s','t','o','r','y','\0'};
	int i=0;
	if(strlen(buf)==0) return 0;
	if(strlen(buf)==1 && buf[0]=='\n') return 0;
	while(i<strlen(hi))
     2da:	83 ec 0c             	sub    $0xc,%esp
     2dd:	8d 45 ec             	lea    -0x14(%ebp),%eax
     2e0:	50                   	push   %eax
     2e1:	e8 6e 0b 00 00       	call   e54 <strlen>
     2e6:	83 c4 10             	add    $0x10,%esp
     2e9:	89 c2                	mov    %eax,%edx
     2eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2ee:	39 c2                	cmp    %eax,%edx
     2f0:	77 c3                	ja     2b5 <cmdCheck+0x6a>
	{	if(buf[i]!=hi[i]) return 1;
		i++;
	}
	return 0;
     2f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2f7:	c9                   	leave  
     2f8:	c3                   	ret    

000002f9 <getcmd>:

int
getcmd(char *buf, int nbuf)
{
     2f9:	55                   	push   %ebp
     2fa:	89 e5                	mov    %esp,%ebp
     2fc:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     2ff:	83 ec 08             	sub    $0x8,%esp
     302:	68 24 17 00 00       	push   $0x1724
     307:	6a 02                	push   $0x2
     309:	e8 19 10 00 00       	call   1327 <printf>
     30e:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     311:	8b 45 0c             	mov    0xc(%ebp),%eax
     314:	83 ec 04             	sub    $0x4,%esp
     317:	50                   	push   %eax
     318:	6a 00                	push   $0x0
     31a:	ff 75 08             	pushl  0x8(%ebp)
     31d:	e8 59 0b 00 00       	call   e7b <memset>
     322:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     325:	83 ec 08             	sub    $0x8,%esp
     328:	ff 75 0c             	pushl  0xc(%ebp)
     32b:	ff 75 08             	pushl  0x8(%ebp)
     32e:	e8 95 0b 00 00       	call   ec8 <gets>
     333:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     336:	8b 45 08             	mov    0x8(%ebp),%eax
     339:	0f b6 00             	movzbl (%eax),%eax
     33c:	84 c0                	test   %al,%al
     33e:	75 07                	jne    347 <getcmd+0x4e>
    return -1; 
     340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     345:	eb 4b                	jmp    392 <getcmd+0x99>
  printf(1,"History Added: %s\n",his);
  if(fork1() == 0)
 	runcmd(parsecmd(his));
  wait();
*/
  if(cmdCheck(buf)) 
     347:	83 ec 0c             	sub    $0xc,%esp
     34a:	ff 75 08             	pushl  0x8(%ebp)
     34d:	e8 f9 fe ff ff       	call   24b <cmdCheck>
     352:	83 c4 10             	add    $0x10,%esp
     355:	85 c0                	test   %eax,%eax
     357:	74 22                	je     37b <getcmd+0x82>
  {	historyAdd(buf);
     359:	83 ec 0c             	sub    $0xc,%esp
     35c:	ff 75 08             	pushl  0x8(%ebp)
     35f:	e8 aa 0c 00 00       	call   100e <historyAdd>
     364:	83 c4 10             	add    $0x10,%esp
	printf(1,"added\n");
     367:	83 ec 08             	sub    $0x8,%esp
     36a:	68 27 17 00 00       	push   $0x1727
     36f:	6a 01                	push   $0x1
     371:	e8 b1 0f 00 00       	call   1327 <printf>
     376:	83 c4 10             	add    $0x10,%esp
     379:	eb 12                	jmp    38d <getcmd+0x94>
  }else{
	printf(1,"not added\n");
     37b:	83 ec 08             	sub    $0x8,%esp
     37e:	68 2e 17 00 00       	push   $0x172e
     383:	6a 01                	push   $0x1
     385:	e8 9d 0f 00 00       	call   1327 <printf>
     38a:	83 c4 10             	add    $0x10,%esp
  }
  return 0;
     38d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     392:	c9                   	leave  
     393:	c3                   	ret    

00000394 <main>:

int
main(void)
{
     394:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     398:	83 e4 f0             	and    $0xfffffff0,%esp
     39b:	ff 71 fc             	pushl  -0x4(%ecx)
     39e:	55                   	push   %ebp
     39f:	89 e5                	mov    %esp,%ebp
     3a1:	51                   	push   %ecx
     3a2:	83 ec 44             	sub    $0x44,%esp
  static char buf[100];
  int fd;

  char his[50];
  his[0]='e';
     3a5:	c6 45 c2 65          	movb   $0x65,-0x3e(%ebp)
  his[1]='c';
     3a9:	c6 45 c3 63          	movb   $0x63,-0x3d(%ebp)
  his[2]='h';
     3ad:	c6 45 c4 68          	movb   $0x68,-0x3c(%ebp)
  his[3]='o';
     3b1:	c6 45 c5 6f          	movb   $0x6f,-0x3b(%ebp)
  his[4]=' ';
     3b5:	c6 45 c6 20          	movb   $0x20,-0x3a(%ebp)
  his[5]='>';
     3b9:	c6 45 c7 3e          	movb   $0x3e,-0x39(%ebp)
  his[6]=' ';
     3bd:	c6 45 c8 20          	movb   $0x20,-0x38(%ebp)
  his[7]='h';
     3c1:	c6 45 c9 68          	movb   $0x68,-0x37(%ebp)
  his[8]=0;
     3c5:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  if(fork1() == 0)
     3c9:	e8 2f 01 00 00       	call   4fd <fork1>
     3ce:	85 c0                	test   %eax,%eax
     3d0:	75 1b                	jne    3ed <main+0x59>
 	runcmd(parsecmd(his));
     3d2:	83 ec 0c             	sub    $0xc,%esp
     3d5:	8d 45 c2             	lea    -0x3e(%ebp),%eax
     3d8:	50                   	push   %eax
     3d9:	e8 77 04 00 00       	call   855 <parsecmd>
     3de:	83 c4 10             	add    $0x10,%esp
     3e1:	83 ec 0c             	sub    $0xc,%esp
     3e4:	50                   	push   %eax
     3e5:	e8 16 fc ff ff       	call   0 <runcmd>
     3ea:	83 c4 10             	add    $0x10,%esp
  wait();
     3ed:	e8 c6 0d 00 00       	call   11b8 <wait>

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     3f2:	eb 16                	jmp    40a <main+0x76>

    if(fd >= 3){
     3f4:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     3f8:	7e 10                	jle    40a <main+0x76>
      close(fd);
     3fa:	83 ec 0c             	sub    $0xc,%esp
     3fd:	ff 75 f4             	pushl  -0xc(%ebp)
     400:	e8 d3 0d 00 00       	call   11d8 <close>
     405:	83 c4 10             	add    $0x10,%esp
      break;
     408:	eb 1b                	jmp    425 <main+0x91>
  if(fork1() == 0)
 	runcmd(parsecmd(his));
  wait();

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     40a:	83 ec 08             	sub    $0x8,%esp
     40d:	6a 02                	push   $0x2
     40f:	68 39 17 00 00       	push   $0x1739
     414:	e8 d7 0d 00 00       	call   11f0 <open>
     419:	83 c4 10             	add    $0x10,%esp
     41c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     41f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     423:	79 cf                	jns    3f4 <main+0x60>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     425:	e9 94 00 00 00       	jmp    4be <main+0x12a>

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     42a:	0f b6 05 20 1d 00 00 	movzbl 0x1d20,%eax
     431:	3c 63                	cmp    $0x63,%al
     433:	75 5f                	jne    494 <main+0x100>
     435:	0f b6 05 21 1d 00 00 	movzbl 0x1d21,%eax
     43c:	3c 64                	cmp    $0x64,%al
     43e:	75 54                	jne    494 <main+0x100>
     440:	0f b6 05 22 1d 00 00 	movzbl 0x1d22,%eax
     447:	3c 20                	cmp    $0x20,%al
     449:	75 49                	jne    494 <main+0x100>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     44b:	83 ec 0c             	sub    $0xc,%esp
     44e:	68 20 1d 00 00       	push   $0x1d20
     453:	e8 fc 09 00 00       	call   e54 <strlen>
     458:	83 c4 10             	add    $0x10,%esp
     45b:	83 e8 01             	sub    $0x1,%eax
     45e:	c6 80 20 1d 00 00 00 	movb   $0x0,0x1d20(%eax)
      if(chdir(buf+3) < 0)
     465:	b8 23 1d 00 00       	mov    $0x1d23,%eax
     46a:	83 ec 0c             	sub    $0xc,%esp
     46d:	50                   	push   %eax
     46e:	e8 ad 0d 00 00       	call   1220 <chdir>
     473:	83 c4 10             	add    $0x10,%esp
     476:	85 c0                	test   %eax,%eax
     478:	79 44                	jns    4be <main+0x12a>
        printf(2, "cannot cd %s\n", buf+3);
     47a:	b8 23 1d 00 00       	mov    $0x1d23,%eax
     47f:	83 ec 04             	sub    $0x4,%esp
     482:	50                   	push   %eax
     483:	68 41 17 00 00       	push   $0x1741
     488:	6a 02                	push   $0x2
     48a:	e8 98 0e 00 00       	call   1327 <printf>
     48f:	83 c4 10             	add    $0x10,%esp
      continue;
     492:	eb 2a                	jmp    4be <main+0x12a>
    }
    if(fork1() == 0)
     494:	e8 64 00 00 00       	call   4fd <fork1>
     499:	85 c0                	test   %eax,%eax
     49b:	75 1c                	jne    4b9 <main+0x125>
      runcmd(parsecmd(buf));
     49d:	83 ec 0c             	sub    $0xc,%esp
     4a0:	68 20 1d 00 00       	push   $0x1d20
     4a5:	e8 ab 03 00 00       	call   855 <parsecmd>
     4aa:	83 c4 10             	add    $0x10,%esp
     4ad:	83 ec 0c             	sub    $0xc,%esp
     4b0:	50                   	push   %eax
     4b1:	e8 4a fb ff ff       	call   0 <runcmd>
     4b6:	83 c4 10             	add    $0x10,%esp
    wait();
     4b9:	e8 fa 0c 00 00       	call   11b8 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     4be:	83 ec 08             	sub    $0x8,%esp
     4c1:	6a 64                	push   $0x64
     4c3:	68 20 1d 00 00       	push   $0x1d20
     4c8:	e8 2c fe ff ff       	call   2f9 <getcmd>
     4cd:	83 c4 10             	add    $0x10,%esp
     4d0:	85 c0                	test   %eax,%eax
     4d2:	0f 89 52 ff ff ff    	jns    42a <main+0x96>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     4d8:	e8 d3 0c 00 00       	call   11b0 <exit>

000004dd <panic>:
}

void
panic(char *s)
{
     4dd:	55                   	push   %ebp
     4de:	89 e5                	mov    %esp,%ebp
     4e0:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     4e3:	83 ec 04             	sub    $0x4,%esp
     4e6:	ff 75 08             	pushl  0x8(%ebp)
     4e9:	68 4f 17 00 00       	push   $0x174f
     4ee:	6a 02                	push   $0x2
     4f0:	e8 32 0e 00 00       	call   1327 <printf>
     4f5:	83 c4 10             	add    $0x10,%esp
  exit();
     4f8:	e8 b3 0c 00 00       	call   11b0 <exit>

000004fd <fork1>:
}

int
fork1(void)
{
     4fd:	55                   	push   %ebp
     4fe:	89 e5                	mov    %esp,%ebp
     500:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     503:	e8 a0 0c 00 00       	call   11a8 <fork>
     508:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     50b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     50f:	75 10                	jne    521 <fork1+0x24>
    panic("fork");
     511:	83 ec 0c             	sub    $0xc,%esp
     514:	68 53 17 00 00       	push   $0x1753
     519:	e8 bf ff ff ff       	call   4dd <panic>
     51e:	83 c4 10             	add    $0x10,%esp
  return pid;
     521:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     524:	c9                   	leave  
     525:	c3                   	ret    

00000526 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     526:	55                   	push   %ebp
     527:	89 e5                	mov    %esp,%ebp
     529:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     52c:	83 ec 0c             	sub    $0xc,%esp
     52f:	6a 54                	push   $0x54
     531:	e8 c4 10 00 00       	call   15fa <malloc>
     536:	83 c4 10             	add    $0x10,%esp
     539:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     53c:	83 ec 04             	sub    $0x4,%esp
     53f:	6a 54                	push   $0x54
     541:	6a 00                	push   $0x0
     543:	ff 75 f4             	pushl  -0xc(%ebp)
     546:	e8 30 09 00 00       	call   e7b <memset>
     54b:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     54e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     551:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     557:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     55a:	c9                   	leave  
     55b:	c3                   	ret    

0000055c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     55c:	55                   	push   %ebp
     55d:	89 e5                	mov    %esp,%ebp
     55f:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     562:	83 ec 0c             	sub    $0xc,%esp
     565:	6a 18                	push   $0x18
     567:	e8 8e 10 00 00       	call   15fa <malloc>
     56c:	83 c4 10             	add    $0x10,%esp
     56f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     572:	83 ec 04             	sub    $0x4,%esp
     575:	6a 18                	push   $0x18
     577:	6a 00                	push   $0x0
     579:	ff 75 f4             	pushl  -0xc(%ebp)
     57c:	e8 fa 08 00 00       	call   e7b <memset>
     581:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     584:	8b 45 f4             	mov    -0xc(%ebp),%eax
     587:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     58d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     590:	8b 55 08             	mov    0x8(%ebp),%edx
     593:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     596:	8b 45 f4             	mov    -0xc(%ebp),%eax
     599:	8b 55 0c             	mov    0xc(%ebp),%edx
     59c:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     59f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a2:	8b 55 10             	mov    0x10(%ebp),%edx
     5a5:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     5a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ab:	8b 55 14             	mov    0x14(%ebp),%edx
     5ae:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     5b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5b4:	8b 55 18             	mov    0x18(%ebp),%edx
     5b7:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     5ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     5bd:	c9                   	leave  
     5be:	c3                   	ret    

000005bf <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     5bf:	55                   	push   %ebp
     5c0:	89 e5                	mov    %esp,%ebp
     5c2:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5c5:	83 ec 0c             	sub    $0xc,%esp
     5c8:	6a 0c                	push   $0xc
     5ca:	e8 2b 10 00 00       	call   15fa <malloc>
     5cf:	83 c4 10             	add    $0x10,%esp
     5d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	6a 0c                	push   $0xc
     5da:	6a 00                	push   $0x0
     5dc:	ff 75 f4             	pushl  -0xc(%ebp)
     5df:	e8 97 08 00 00       	call   e7b <memset>
     5e4:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     5e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ea:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     5f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f3:	8b 55 08             	mov    0x8(%ebp),%edx
     5f6:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     5f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fc:	8b 55 0c             	mov    0xc(%ebp),%edx
     5ff:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     602:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     605:	c9                   	leave  
     606:	c3                   	ret    

00000607 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     607:	55                   	push   %ebp
     608:	89 e5                	mov    %esp,%ebp
     60a:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     60d:	83 ec 0c             	sub    $0xc,%esp
     610:	6a 0c                	push   $0xc
     612:	e8 e3 0f 00 00       	call   15fa <malloc>
     617:	83 c4 10             	add    $0x10,%esp
     61a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     61d:	83 ec 04             	sub    $0x4,%esp
     620:	6a 0c                	push   $0xc
     622:	6a 00                	push   $0x0
     624:	ff 75 f4             	pushl  -0xc(%ebp)
     627:	e8 4f 08 00 00       	call   e7b <memset>
     62c:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     62f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     632:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     638:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63b:	8b 55 08             	mov    0x8(%ebp),%edx
     63e:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     641:	8b 45 f4             	mov    -0xc(%ebp),%eax
     644:	8b 55 0c             	mov    0xc(%ebp),%edx
     647:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     64a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     64d:	c9                   	leave  
     64e:	c3                   	ret    

0000064f <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     64f:	55                   	push   %ebp
     650:	89 e5                	mov    %esp,%ebp
     652:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     655:	83 ec 0c             	sub    $0xc,%esp
     658:	6a 08                	push   $0x8
     65a:	e8 9b 0f 00 00       	call   15fa <malloc>
     65f:	83 c4 10             	add    $0x10,%esp
     662:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     665:	83 ec 04             	sub    $0x4,%esp
     668:	6a 08                	push   $0x8
     66a:	6a 00                	push   $0x0
     66c:	ff 75 f4             	pushl  -0xc(%ebp)
     66f:	e8 07 08 00 00       	call   e7b <memset>
     674:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     677:	8b 45 f4             	mov    -0xc(%ebp),%eax
     67a:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     680:	8b 45 f4             	mov    -0xc(%ebp),%eax
     683:	8b 55 08             	mov    0x8(%ebp),%edx
     686:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     689:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     68c:	c9                   	leave  
     68d:	c3                   	ret    

0000068e <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     68e:	55                   	push   %ebp
     68f:	89 e5                	mov    %esp,%ebp
     691:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     694:	8b 45 08             	mov    0x8(%ebp),%eax
     697:	8b 00                	mov    (%eax),%eax
     699:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     69c:	eb 04                	jmp    6a2 <gettoken+0x14>
    s++;
     69e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     6a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6a8:	73 1e                	jae    6c8 <gettoken+0x3a>
     6aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ad:	0f b6 00             	movzbl (%eax),%eax
     6b0:	0f be c0             	movsbl %al,%eax
     6b3:	83 ec 08             	sub    $0x8,%esp
     6b6:	50                   	push   %eax
     6b7:	68 f4 1c 00 00       	push   $0x1cf4
     6bc:	e8 d4 07 00 00       	call   e95 <strchr>
     6c1:	83 c4 10             	add    $0x10,%esp
     6c4:	85 c0                	test   %eax,%eax
     6c6:	75 d6                	jne    69e <gettoken+0x10>
    s++;
  if(q)
     6c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     6cc:	74 08                	je     6d6 <gettoken+0x48>
    *q = s;
     6ce:	8b 45 10             	mov    0x10(%ebp),%eax
     6d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6d4:	89 10                	mov    %edx,(%eax)
  ret = *s;
     6d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d9:	0f b6 00             	movzbl (%eax),%eax
     6dc:	0f be c0             	movsbl %al,%eax
     6df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     6e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e5:	0f b6 00             	movzbl (%eax),%eax
     6e8:	0f be c0             	movsbl %al,%eax
     6eb:	83 f8 29             	cmp    $0x29,%eax
     6ee:	7f 14                	jg     704 <gettoken+0x76>
     6f0:	83 f8 28             	cmp    $0x28,%eax
     6f3:	7d 28                	jge    71d <gettoken+0x8f>
     6f5:	85 c0                	test   %eax,%eax
     6f7:	0f 84 94 00 00 00    	je     791 <gettoken+0x103>
     6fd:	83 f8 26             	cmp    $0x26,%eax
     700:	74 1b                	je     71d <gettoken+0x8f>
     702:	eb 3a                	jmp    73e <gettoken+0xb0>
     704:	83 f8 3e             	cmp    $0x3e,%eax
     707:	74 1a                	je     723 <gettoken+0x95>
     709:	83 f8 3e             	cmp    $0x3e,%eax
     70c:	7f 0a                	jg     718 <gettoken+0x8a>
     70e:	83 e8 3b             	sub    $0x3b,%eax
     711:	83 f8 01             	cmp    $0x1,%eax
     714:	77 28                	ja     73e <gettoken+0xb0>
     716:	eb 05                	jmp    71d <gettoken+0x8f>
     718:	83 f8 7c             	cmp    $0x7c,%eax
     71b:	75 21                	jne    73e <gettoken+0xb0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     71d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     721:	eb 75                	jmp    798 <gettoken+0x10a>
  case '>':
    s++;
     723:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     727:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72a:	0f b6 00             	movzbl (%eax),%eax
     72d:	3c 3e                	cmp    $0x3e,%al
     72f:	75 63                	jne    794 <gettoken+0x106>
      ret = '+';
     731:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     738:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     73c:	eb 56                	jmp    794 <gettoken+0x106>
  default:
    ret = 'a';
     73e:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     745:	eb 04                	jmp    74b <gettoken+0xbd>
      s++;
     747:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     74b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     74e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     751:	73 44                	jae    797 <gettoken+0x109>
     753:	8b 45 f4             	mov    -0xc(%ebp),%eax
     756:	0f b6 00             	movzbl (%eax),%eax
     759:	0f be c0             	movsbl %al,%eax
     75c:	83 ec 08             	sub    $0x8,%esp
     75f:	50                   	push   %eax
     760:	68 f4 1c 00 00       	push   $0x1cf4
     765:	e8 2b 07 00 00       	call   e95 <strchr>
     76a:	83 c4 10             	add    $0x10,%esp
     76d:	85 c0                	test   %eax,%eax
     76f:	75 26                	jne    797 <gettoken+0x109>
     771:	8b 45 f4             	mov    -0xc(%ebp),%eax
     774:	0f b6 00             	movzbl (%eax),%eax
     777:	0f be c0             	movsbl %al,%eax
     77a:	83 ec 08             	sub    $0x8,%esp
     77d:	50                   	push   %eax
     77e:	68 fc 1c 00 00       	push   $0x1cfc
     783:	e8 0d 07 00 00       	call   e95 <strchr>
     788:	83 c4 10             	add    $0x10,%esp
     78b:	85 c0                	test   %eax,%eax
     78d:	74 b8                	je     747 <gettoken+0xb9>
      s++;
    break;
     78f:	eb 06                	jmp    797 <gettoken+0x109>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     791:	90                   	nop
     792:	eb 04                	jmp    798 <gettoken+0x10a>
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
     794:	90                   	nop
     795:	eb 01                	jmp    798 <gettoken+0x10a>
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
     797:	90                   	nop
  }
  if(eq)
     798:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     79c:	74 0e                	je     7ac <gettoken+0x11e>
    *eq = s;
     79e:	8b 45 14             	mov    0x14(%ebp),%eax
     7a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7a4:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     7a6:	eb 04                	jmp    7ac <gettoken+0x11e>
    s++;
     7a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     7ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7af:	3b 45 0c             	cmp    0xc(%ebp),%eax
     7b2:	73 1e                	jae    7d2 <gettoken+0x144>
     7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b7:	0f b6 00             	movzbl (%eax),%eax
     7ba:	0f be c0             	movsbl %al,%eax
     7bd:	83 ec 08             	sub    $0x8,%esp
     7c0:	50                   	push   %eax
     7c1:	68 f4 1c 00 00       	push   $0x1cf4
     7c6:	e8 ca 06 00 00       	call   e95 <strchr>
     7cb:	83 c4 10             	add    $0x10,%esp
     7ce:	85 c0                	test   %eax,%eax
     7d0:	75 d6                	jne    7a8 <gettoken+0x11a>
    s++;
  *ps = s;
     7d2:	8b 45 08             	mov    0x8(%ebp),%eax
     7d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7d8:	89 10                	mov    %edx,(%eax)
  return ret;
     7da:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     7dd:	c9                   	leave  
     7de:	c3                   	ret    

000007df <peek>:

int
peek(char **ps, char *es, char *toks)
{
     7df:	55                   	push   %ebp
     7e0:	89 e5                	mov    %esp,%ebp
     7e2:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     7e5:	8b 45 08             	mov    0x8(%ebp),%eax
     7e8:	8b 00                	mov    (%eax),%eax
     7ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     7ed:	eb 04                	jmp    7f3 <peek+0x14>
    s++;
     7ef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f6:	3b 45 0c             	cmp    0xc(%ebp),%eax
     7f9:	73 1e                	jae    819 <peek+0x3a>
     7fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fe:	0f b6 00             	movzbl (%eax),%eax
     801:	0f be c0             	movsbl %al,%eax
     804:	83 ec 08             	sub    $0x8,%esp
     807:	50                   	push   %eax
     808:	68 f4 1c 00 00       	push   $0x1cf4
     80d:	e8 83 06 00 00       	call   e95 <strchr>
     812:	83 c4 10             	add    $0x10,%esp
     815:	85 c0                	test   %eax,%eax
     817:	75 d6                	jne    7ef <peek+0x10>
    s++;
  *ps = s;
     819:	8b 45 08             	mov    0x8(%ebp),%eax
     81c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     81f:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     821:	8b 45 f4             	mov    -0xc(%ebp),%eax
     824:	0f b6 00             	movzbl (%eax),%eax
     827:	84 c0                	test   %al,%al
     829:	74 23                	je     84e <peek+0x6f>
     82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82e:	0f b6 00             	movzbl (%eax),%eax
     831:	0f be c0             	movsbl %al,%eax
     834:	83 ec 08             	sub    $0x8,%esp
     837:	50                   	push   %eax
     838:	ff 75 10             	pushl  0x10(%ebp)
     83b:	e8 55 06 00 00       	call   e95 <strchr>
     840:	83 c4 10             	add    $0x10,%esp
     843:	85 c0                	test   %eax,%eax
     845:	74 07                	je     84e <peek+0x6f>
     847:	b8 01 00 00 00       	mov    $0x1,%eax
     84c:	eb 05                	jmp    853 <peek+0x74>
     84e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     853:	c9                   	leave  
     854:	c3                   	ret    

00000855 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     855:	55                   	push   %ebp
     856:	89 e5                	mov    %esp,%ebp
     858:	53                   	push   %ebx
     859:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     85c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     85f:	8b 45 08             	mov    0x8(%ebp),%eax
     862:	83 ec 0c             	sub    $0xc,%esp
     865:	50                   	push   %eax
     866:	e8 e9 05 00 00       	call   e54 <strlen>
     86b:	83 c4 10             	add    $0x10,%esp
     86e:	01 d8                	add    %ebx,%eax
     870:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     873:	83 ec 08             	sub    $0x8,%esp
     876:	ff 75 f4             	pushl  -0xc(%ebp)
     879:	8d 45 08             	lea    0x8(%ebp),%eax
     87c:	50                   	push   %eax
     87d:	e8 61 00 00 00       	call   8e3 <parseline>
     882:	83 c4 10             	add    $0x10,%esp
     885:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     888:	83 ec 04             	sub    $0x4,%esp
     88b:	68 58 17 00 00       	push   $0x1758
     890:	ff 75 f4             	pushl  -0xc(%ebp)
     893:	8d 45 08             	lea    0x8(%ebp),%eax
     896:	50                   	push   %eax
     897:	e8 43 ff ff ff       	call   7df <peek>
     89c:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     89f:	8b 45 08             	mov    0x8(%ebp),%eax
     8a2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     8a5:	74 26                	je     8cd <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     8a7:	8b 45 08             	mov    0x8(%ebp),%eax
     8aa:	83 ec 04             	sub    $0x4,%esp
     8ad:	50                   	push   %eax
     8ae:	68 59 17 00 00       	push   $0x1759
     8b3:	6a 02                	push   $0x2
     8b5:	e8 6d 0a 00 00       	call   1327 <printf>
     8ba:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     8bd:	83 ec 0c             	sub    $0xc,%esp
     8c0:	68 68 17 00 00       	push   $0x1768
     8c5:	e8 13 fc ff ff       	call   4dd <panic>
     8ca:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     8cd:	83 ec 0c             	sub    $0xc,%esp
     8d0:	ff 75 f0             	pushl  -0x10(%ebp)
     8d3:	e8 eb 03 00 00       	call   cc3 <nulterminate>
     8d8:	83 c4 10             	add    $0x10,%esp
  return cmd;
     8db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     8de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e1:	c9                   	leave  
     8e2:	c3                   	ret    

000008e3 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     8e3:	55                   	push   %ebp
     8e4:	89 e5                	mov    %esp,%ebp
     8e6:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     8e9:	83 ec 08             	sub    $0x8,%esp
     8ec:	ff 75 0c             	pushl  0xc(%ebp)
     8ef:	ff 75 08             	pushl  0x8(%ebp)
     8f2:	e8 99 00 00 00       	call   990 <parsepipe>
     8f7:	83 c4 10             	add    $0x10,%esp
     8fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     8fd:	eb 23                	jmp    922 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     8ff:	6a 00                	push   $0x0
     901:	6a 00                	push   $0x0
     903:	ff 75 0c             	pushl  0xc(%ebp)
     906:	ff 75 08             	pushl  0x8(%ebp)
     909:	e8 80 fd ff ff       	call   68e <gettoken>
     90e:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     911:	83 ec 0c             	sub    $0xc,%esp
     914:	ff 75 f4             	pushl  -0xc(%ebp)
     917:	e8 33 fd ff ff       	call   64f <backcmd>
     91c:	83 c4 10             	add    $0x10,%esp
     91f:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     922:	83 ec 04             	sub    $0x4,%esp
     925:	68 6f 17 00 00       	push   $0x176f
     92a:	ff 75 0c             	pushl  0xc(%ebp)
     92d:	ff 75 08             	pushl  0x8(%ebp)
     930:	e8 aa fe ff ff       	call   7df <peek>
     935:	83 c4 10             	add    $0x10,%esp
     938:	85 c0                	test   %eax,%eax
     93a:	75 c3                	jne    8ff <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     93c:	83 ec 04             	sub    $0x4,%esp
     93f:	68 71 17 00 00       	push   $0x1771
     944:	ff 75 0c             	pushl  0xc(%ebp)
     947:	ff 75 08             	pushl  0x8(%ebp)
     94a:	e8 90 fe ff ff       	call   7df <peek>
     94f:	83 c4 10             	add    $0x10,%esp
     952:	85 c0                	test   %eax,%eax
     954:	74 35                	je     98b <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     956:	6a 00                	push   $0x0
     958:	6a 00                	push   $0x0
     95a:	ff 75 0c             	pushl  0xc(%ebp)
     95d:	ff 75 08             	pushl  0x8(%ebp)
     960:	e8 29 fd ff ff       	call   68e <gettoken>
     965:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     968:	83 ec 08             	sub    $0x8,%esp
     96b:	ff 75 0c             	pushl  0xc(%ebp)
     96e:	ff 75 08             	pushl  0x8(%ebp)
     971:	e8 6d ff ff ff       	call   8e3 <parseline>
     976:	83 c4 10             	add    $0x10,%esp
     979:	83 ec 08             	sub    $0x8,%esp
     97c:	50                   	push   %eax
     97d:	ff 75 f4             	pushl  -0xc(%ebp)
     980:	e8 82 fc ff ff       	call   607 <listcmd>
     985:	83 c4 10             	add    $0x10,%esp
     988:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     98b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     98e:	c9                   	leave  
     98f:	c3                   	ret    

00000990 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     996:	83 ec 08             	sub    $0x8,%esp
     999:	ff 75 0c             	pushl  0xc(%ebp)
     99c:	ff 75 08             	pushl  0x8(%ebp)
     99f:	e8 ec 01 00 00       	call   b90 <parseexec>
     9a4:	83 c4 10             	add    $0x10,%esp
     9a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     9aa:	83 ec 04             	sub    $0x4,%esp
     9ad:	68 73 17 00 00       	push   $0x1773
     9b2:	ff 75 0c             	pushl  0xc(%ebp)
     9b5:	ff 75 08             	pushl  0x8(%ebp)
     9b8:	e8 22 fe ff ff       	call   7df <peek>
     9bd:	83 c4 10             	add    $0x10,%esp
     9c0:	85 c0                	test   %eax,%eax
     9c2:	74 35                	je     9f9 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     9c4:	6a 00                	push   $0x0
     9c6:	6a 00                	push   $0x0
     9c8:	ff 75 0c             	pushl  0xc(%ebp)
     9cb:	ff 75 08             	pushl  0x8(%ebp)
     9ce:	e8 bb fc ff ff       	call   68e <gettoken>
     9d3:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9d6:	83 ec 08             	sub    $0x8,%esp
     9d9:	ff 75 0c             	pushl  0xc(%ebp)
     9dc:	ff 75 08             	pushl  0x8(%ebp)
     9df:	e8 ac ff ff ff       	call   990 <parsepipe>
     9e4:	83 c4 10             	add    $0x10,%esp
     9e7:	83 ec 08             	sub    $0x8,%esp
     9ea:	50                   	push   %eax
     9eb:	ff 75 f4             	pushl  -0xc(%ebp)
     9ee:	e8 cc fb ff ff       	call   5bf <pipecmd>
     9f3:	83 c4 10             	add    $0x10,%esp
     9f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     9f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     9fc:	c9                   	leave  
     9fd:	c3                   	ret    

000009fe <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     9fe:	55                   	push   %ebp
     9ff:	89 e5                	mov    %esp,%ebp
     a01:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     a04:	e9 b6 00 00 00       	jmp    abf <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     a09:	6a 00                	push   $0x0
     a0b:	6a 00                	push   $0x0
     a0d:	ff 75 10             	pushl  0x10(%ebp)
     a10:	ff 75 0c             	pushl  0xc(%ebp)
     a13:	e8 76 fc ff ff       	call   68e <gettoken>
     a18:	83 c4 10             	add    $0x10,%esp
     a1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     a1e:	8d 45 ec             	lea    -0x14(%ebp),%eax
     a21:	50                   	push   %eax
     a22:	8d 45 f0             	lea    -0x10(%ebp),%eax
     a25:	50                   	push   %eax
     a26:	ff 75 10             	pushl  0x10(%ebp)
     a29:	ff 75 0c             	pushl  0xc(%ebp)
     a2c:	e8 5d fc ff ff       	call   68e <gettoken>
     a31:	83 c4 10             	add    $0x10,%esp
     a34:	83 f8 61             	cmp    $0x61,%eax
     a37:	74 10                	je     a49 <parseredirs+0x4b>
      panic("missing file for redirection");
     a39:	83 ec 0c             	sub    $0xc,%esp
     a3c:	68 75 17 00 00       	push   $0x1775
     a41:	e8 97 fa ff ff       	call   4dd <panic>
     a46:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4c:	83 f8 3c             	cmp    $0x3c,%eax
     a4f:	74 0c                	je     a5d <parseredirs+0x5f>
     a51:	83 f8 3e             	cmp    $0x3e,%eax
     a54:	74 26                	je     a7c <parseredirs+0x7e>
     a56:	83 f8 2b             	cmp    $0x2b,%eax
     a59:	74 43                	je     a9e <parseredirs+0xa0>
     a5b:	eb 62                	jmp    abf <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a5d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a63:	83 ec 0c             	sub    $0xc,%esp
     a66:	6a 00                	push   $0x0
     a68:	6a 00                	push   $0x0
     a6a:	52                   	push   %edx
     a6b:	50                   	push   %eax
     a6c:	ff 75 08             	pushl  0x8(%ebp)
     a6f:	e8 e8 fa ff ff       	call   55c <redircmd>
     a74:	83 c4 20             	add    $0x20,%esp
     a77:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     a7a:	eb 43                	jmp    abf <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a7c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a82:	83 ec 0c             	sub    $0xc,%esp
     a85:	6a 01                	push   $0x1
     a87:	68 01 02 00 00       	push   $0x201
     a8c:	52                   	push   %edx
     a8d:	50                   	push   %eax
     a8e:	ff 75 08             	pushl  0x8(%ebp)
     a91:	e8 c6 fa ff ff       	call   55c <redircmd>
     a96:	83 c4 20             	add    $0x20,%esp
     a99:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     a9c:	eb 21                	jmp    abf <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a9e:	8b 55 ec             	mov    -0x14(%ebp),%edx
     aa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa4:	83 ec 0c             	sub    $0xc,%esp
     aa7:	6a 01                	push   $0x1
     aa9:	68 01 02 00 00       	push   $0x201
     aae:	52                   	push   %edx
     aaf:	50                   	push   %eax
     ab0:	ff 75 08             	pushl  0x8(%ebp)
     ab3:	e8 a4 fa ff ff       	call   55c <redircmd>
     ab8:	83 c4 20             	add    $0x20,%esp
     abb:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     abe:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     abf:	83 ec 04             	sub    $0x4,%esp
     ac2:	68 92 17 00 00       	push   $0x1792
     ac7:	ff 75 10             	pushl  0x10(%ebp)
     aca:	ff 75 0c             	pushl  0xc(%ebp)
     acd:	e8 0d fd ff ff       	call   7df <peek>
     ad2:	83 c4 10             	add    $0x10,%esp
     ad5:	85 c0                	test   %eax,%eax
     ad7:	0f 85 2c ff ff ff    	jne    a09 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     add:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ae0:	c9                   	leave  
     ae1:	c3                   	ret    

00000ae2 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     ae2:	55                   	push   %ebp
     ae3:	89 e5                	mov    %esp,%ebp
     ae5:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     ae8:	83 ec 04             	sub    $0x4,%esp
     aeb:	68 95 17 00 00       	push   $0x1795
     af0:	ff 75 0c             	pushl  0xc(%ebp)
     af3:	ff 75 08             	pushl  0x8(%ebp)
     af6:	e8 e4 fc ff ff       	call   7df <peek>
     afb:	83 c4 10             	add    $0x10,%esp
     afe:	85 c0                	test   %eax,%eax
     b00:	75 10                	jne    b12 <parseblock+0x30>
    panic("parseblock");
     b02:	83 ec 0c             	sub    $0xc,%esp
     b05:	68 97 17 00 00       	push   $0x1797
     b0a:	e8 ce f9 ff ff       	call   4dd <panic>
     b0f:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     b12:	6a 00                	push   $0x0
     b14:	6a 00                	push   $0x0
     b16:	ff 75 0c             	pushl  0xc(%ebp)
     b19:	ff 75 08             	pushl  0x8(%ebp)
     b1c:	e8 6d fb ff ff       	call   68e <gettoken>
     b21:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     b24:	83 ec 08             	sub    $0x8,%esp
     b27:	ff 75 0c             	pushl  0xc(%ebp)
     b2a:	ff 75 08             	pushl  0x8(%ebp)
     b2d:	e8 b1 fd ff ff       	call   8e3 <parseline>
     b32:	83 c4 10             	add    $0x10,%esp
     b35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     b38:	83 ec 04             	sub    $0x4,%esp
     b3b:	68 a2 17 00 00       	push   $0x17a2
     b40:	ff 75 0c             	pushl  0xc(%ebp)
     b43:	ff 75 08             	pushl  0x8(%ebp)
     b46:	e8 94 fc ff ff       	call   7df <peek>
     b4b:	83 c4 10             	add    $0x10,%esp
     b4e:	85 c0                	test   %eax,%eax
     b50:	75 10                	jne    b62 <parseblock+0x80>
    panic("syntax - missing )");
     b52:	83 ec 0c             	sub    $0xc,%esp
     b55:	68 a4 17 00 00       	push   $0x17a4
     b5a:	e8 7e f9 ff ff       	call   4dd <panic>
     b5f:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     b62:	6a 00                	push   $0x0
     b64:	6a 00                	push   $0x0
     b66:	ff 75 0c             	pushl  0xc(%ebp)
     b69:	ff 75 08             	pushl  0x8(%ebp)
     b6c:	e8 1d fb ff ff       	call   68e <gettoken>
     b71:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     b74:	83 ec 04             	sub    $0x4,%esp
     b77:	ff 75 0c             	pushl  0xc(%ebp)
     b7a:	ff 75 08             	pushl  0x8(%ebp)
     b7d:	ff 75 f4             	pushl  -0xc(%ebp)
     b80:	e8 79 fe ff ff       	call   9fe <parseredirs>
     b85:	83 c4 10             	add    $0x10,%esp
     b88:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     b8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b8e:	c9                   	leave  
     b8f:	c3                   	ret    

00000b90 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     b96:	83 ec 04             	sub    $0x4,%esp
     b99:	68 95 17 00 00       	push   $0x1795
     b9e:	ff 75 0c             	pushl  0xc(%ebp)
     ba1:	ff 75 08             	pushl  0x8(%ebp)
     ba4:	e8 36 fc ff ff       	call   7df <peek>
     ba9:	83 c4 10             	add    $0x10,%esp
     bac:	85 c0                	test   %eax,%eax
     bae:	74 16                	je     bc6 <parseexec+0x36>
    return parseblock(ps, es);
     bb0:	83 ec 08             	sub    $0x8,%esp
     bb3:	ff 75 0c             	pushl  0xc(%ebp)
     bb6:	ff 75 08             	pushl  0x8(%ebp)
     bb9:	e8 24 ff ff ff       	call   ae2 <parseblock>
     bbe:	83 c4 10             	add    $0x10,%esp
     bc1:	e9 fb 00 00 00       	jmp    cc1 <parseexec+0x131>

  ret = execcmd();
     bc6:	e8 5b f9 ff ff       	call   526 <execcmd>
     bcb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     bce:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd1:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     bd4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     bdb:	83 ec 04             	sub    $0x4,%esp
     bde:	ff 75 0c             	pushl  0xc(%ebp)
     be1:	ff 75 08             	pushl  0x8(%ebp)
     be4:	ff 75 f0             	pushl  -0x10(%ebp)
     be7:	e8 12 fe ff ff       	call   9fe <parseredirs>
     bec:	83 c4 10             	add    $0x10,%esp
     bef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     bf2:	e9 87 00 00 00       	jmp    c7e <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     bf7:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bfa:	50                   	push   %eax
     bfb:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     bfe:	50                   	push   %eax
     bff:	ff 75 0c             	pushl  0xc(%ebp)
     c02:	ff 75 08             	pushl  0x8(%ebp)
     c05:	e8 84 fa ff ff       	call   68e <gettoken>
     c0a:	83 c4 10             	add    $0x10,%esp
     c0d:	89 45 e8             	mov    %eax,-0x18(%ebp)
     c10:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c14:	0f 84 84 00 00 00    	je     c9e <parseexec+0x10e>
      break;
    if(tok != 'a')
     c1a:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     c1e:	74 10                	je     c30 <parseexec+0xa0>
      panic("syntax");
     c20:	83 ec 0c             	sub    $0xc,%esp
     c23:	68 68 17 00 00       	push   $0x1768
     c28:	e8 b0 f8 ff ff       	call   4dd <panic>
     c2d:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     c30:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     c33:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c36:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c39:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     c3d:	8b 55 e0             	mov    -0x20(%ebp),%edx
     c40:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c43:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     c46:	83 c1 08             	add    $0x8,%ecx
     c49:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     c4d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     c51:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     c55:	7e 10                	jle    c67 <parseexec+0xd7>
      panic("too many args");
     c57:	83 ec 0c             	sub    $0xc,%esp
     c5a:	68 b7 17 00 00       	push   $0x17b7
     c5f:	e8 79 f8 ff ff       	call   4dd <panic>
     c64:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     c67:	83 ec 04             	sub    $0x4,%esp
     c6a:	ff 75 0c             	pushl  0xc(%ebp)
     c6d:	ff 75 08             	pushl  0x8(%ebp)
     c70:	ff 75 f0             	pushl  -0x10(%ebp)
     c73:	e8 86 fd ff ff       	call   9fe <parseredirs>
     c78:	83 c4 10             	add    $0x10,%esp
     c7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     c7e:	83 ec 04             	sub    $0x4,%esp
     c81:	68 c5 17 00 00       	push   $0x17c5
     c86:	ff 75 0c             	pushl  0xc(%ebp)
     c89:	ff 75 08             	pushl  0x8(%ebp)
     c8c:	e8 4e fb ff ff       	call   7df <peek>
     c91:	83 c4 10             	add    $0x10,%esp
     c94:	85 c0                	test   %eax,%eax
     c96:	0f 84 5b ff ff ff    	je     bf7 <parseexec+0x67>
     c9c:	eb 01                	jmp    c9f <parseexec+0x10f>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
     c9e:	90                   	nop
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     c9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ca2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ca5:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     cac:	00 
  cmd->eargv[argc] = 0;
     cad:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cb0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cb3:	83 c2 08             	add    $0x8,%edx
     cb6:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     cbd:	00 
  return ret;
     cbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     cc1:	c9                   	leave  
     cc2:	c3                   	ret    

00000cc3 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     cc3:	55                   	push   %ebp
     cc4:	89 e5                	mov    %esp,%ebp
     cc6:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     cc9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     ccd:	75 0a                	jne    cd9 <nulterminate+0x16>
    return 0;
     ccf:	b8 00 00 00 00       	mov    $0x0,%eax
     cd4:	e9 e4 00 00 00       	jmp    dbd <nulterminate+0xfa>
  
  switch(cmd->type){
     cd9:	8b 45 08             	mov    0x8(%ebp),%eax
     cdc:	8b 00                	mov    (%eax),%eax
     cde:	83 f8 05             	cmp    $0x5,%eax
     ce1:	0f 87 d3 00 00 00    	ja     dba <nulterminate+0xf7>
     ce7:	8b 04 85 cc 17 00 00 	mov    0x17cc(,%eax,4),%eax
     cee:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     cf0:	8b 45 08             	mov    0x8(%ebp),%eax
     cf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     cf6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cfd:	eb 14                	jmp    d13 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     cff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d02:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d05:	83 c2 08             	add    $0x8,%edx
     d08:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     d0c:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     d0f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d13:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d16:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d19:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     d1d:	85 c0                	test   %eax,%eax
     d1f:	75 de                	jne    cff <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     d21:	e9 94 00 00 00       	jmp    dba <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     d26:	8b 45 08             	mov    0x8(%ebp),%eax
     d29:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     d2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d2f:	8b 40 04             	mov    0x4(%eax),%eax
     d32:	83 ec 0c             	sub    $0xc,%esp
     d35:	50                   	push   %eax
     d36:	e8 88 ff ff ff       	call   cc3 <nulterminate>
     d3b:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     d3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d41:	8b 40 0c             	mov    0xc(%eax),%eax
     d44:	c6 00 00             	movb   $0x0,(%eax)
    break;
     d47:	eb 71                	jmp    dba <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     d49:	8b 45 08             	mov    0x8(%ebp),%eax
     d4c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     d4f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d52:	8b 40 04             	mov    0x4(%eax),%eax
     d55:	83 ec 0c             	sub    $0xc,%esp
     d58:	50                   	push   %eax
     d59:	e8 65 ff ff ff       	call   cc3 <nulterminate>
     d5e:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     d61:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d64:	8b 40 08             	mov    0x8(%eax),%eax
     d67:	83 ec 0c             	sub    $0xc,%esp
     d6a:	50                   	push   %eax
     d6b:	e8 53 ff ff ff       	call   cc3 <nulterminate>
     d70:	83 c4 10             	add    $0x10,%esp
    break;
     d73:	eb 45                	jmp    dba <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     d75:	8b 45 08             	mov    0x8(%ebp),%eax
     d78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     d7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d7e:	8b 40 04             	mov    0x4(%eax),%eax
     d81:	83 ec 0c             	sub    $0xc,%esp
     d84:	50                   	push   %eax
     d85:	e8 39 ff ff ff       	call   cc3 <nulterminate>
     d8a:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     d8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d90:	8b 40 08             	mov    0x8(%eax),%eax
     d93:	83 ec 0c             	sub    $0xc,%esp
     d96:	50                   	push   %eax
     d97:	e8 27 ff ff ff       	call   cc3 <nulterminate>
     d9c:	83 c4 10             	add    $0x10,%esp
    break;
     d9f:	eb 19                	jmp    dba <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     da1:	8b 45 08             	mov    0x8(%ebp),%eax
     da4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     da7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     daa:	8b 40 04             	mov    0x4(%eax),%eax
     dad:	83 ec 0c             	sub    $0xc,%esp
     db0:	50                   	push   %eax
     db1:	e8 0d ff ff ff       	call   cc3 <nulterminate>
     db6:	83 c4 10             	add    $0x10,%esp
    break;
     db9:	90                   	nop
  }
  return cmd;
     dba:	8b 45 08             	mov    0x8(%ebp),%eax
}
     dbd:	c9                   	leave  
     dbe:	c3                   	ret    

00000dbf <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     dbf:	55                   	push   %ebp
     dc0:	89 e5                	mov    %esp,%ebp
     dc2:	57                   	push   %edi
     dc3:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     dc4:	8b 4d 08             	mov    0x8(%ebp),%ecx
     dc7:	8b 55 10             	mov    0x10(%ebp),%edx
     dca:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcd:	89 cb                	mov    %ecx,%ebx
     dcf:	89 df                	mov    %ebx,%edi
     dd1:	89 d1                	mov    %edx,%ecx
     dd3:	fc                   	cld    
     dd4:	f3 aa                	rep stos %al,%es:(%edi)
     dd6:	89 ca                	mov    %ecx,%edx
     dd8:	89 fb                	mov    %edi,%ebx
     dda:	89 5d 08             	mov    %ebx,0x8(%ebp)
     ddd:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     de0:	90                   	nop
     de1:	5b                   	pop    %ebx
     de2:	5f                   	pop    %edi
     de3:	5d                   	pop    %ebp
     de4:	c3                   	ret    

00000de5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     de5:	55                   	push   %ebp
     de6:	89 e5                	mov    %esp,%ebp
     de8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     deb:	8b 45 08             	mov    0x8(%ebp),%eax
     dee:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     df1:	90                   	nop
     df2:	8b 45 08             	mov    0x8(%ebp),%eax
     df5:	8d 50 01             	lea    0x1(%eax),%edx
     df8:	89 55 08             	mov    %edx,0x8(%ebp)
     dfb:	8b 55 0c             	mov    0xc(%ebp),%edx
     dfe:	8d 4a 01             	lea    0x1(%edx),%ecx
     e01:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     e04:	0f b6 12             	movzbl (%edx),%edx
     e07:	88 10                	mov    %dl,(%eax)
     e09:	0f b6 00             	movzbl (%eax),%eax
     e0c:	84 c0                	test   %al,%al
     e0e:	75 e2                	jne    df2 <strcpy+0xd>
    ;
  return os;
     e10:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e13:	c9                   	leave  
     e14:	c3                   	ret    

00000e15 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e15:	55                   	push   %ebp
     e16:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     e18:	eb 08                	jmp    e22 <strcmp+0xd>
    p++, q++;
     e1a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e1e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     e22:	8b 45 08             	mov    0x8(%ebp),%eax
     e25:	0f b6 00             	movzbl (%eax),%eax
     e28:	84 c0                	test   %al,%al
     e2a:	74 10                	je     e3c <strcmp+0x27>
     e2c:	8b 45 08             	mov    0x8(%ebp),%eax
     e2f:	0f b6 10             	movzbl (%eax),%edx
     e32:	8b 45 0c             	mov    0xc(%ebp),%eax
     e35:	0f b6 00             	movzbl (%eax),%eax
     e38:	38 c2                	cmp    %al,%dl
     e3a:	74 de                	je     e1a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     e3c:	8b 45 08             	mov    0x8(%ebp),%eax
     e3f:	0f b6 00             	movzbl (%eax),%eax
     e42:	0f b6 d0             	movzbl %al,%edx
     e45:	8b 45 0c             	mov    0xc(%ebp),%eax
     e48:	0f b6 00             	movzbl (%eax),%eax
     e4b:	0f b6 c0             	movzbl %al,%eax
     e4e:	29 c2                	sub    %eax,%edx
     e50:	89 d0                	mov    %edx,%eax
}
     e52:	5d                   	pop    %ebp
     e53:	c3                   	ret    

00000e54 <strlen>:

uint
strlen(char *s)
{
     e54:	55                   	push   %ebp
     e55:	89 e5                	mov    %esp,%ebp
     e57:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     e5a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     e61:	eb 04                	jmp    e67 <strlen+0x13>
     e63:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e67:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e6a:	8b 45 08             	mov    0x8(%ebp),%eax
     e6d:	01 d0                	add    %edx,%eax
     e6f:	0f b6 00             	movzbl (%eax),%eax
     e72:	84 c0                	test   %al,%al
     e74:	75 ed                	jne    e63 <strlen+0xf>
    ;
  return n;
     e76:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e79:	c9                   	leave  
     e7a:	c3                   	ret    

00000e7b <memset>:

void*
memset(void *dst, int c, uint n)
{
     e7b:	55                   	push   %ebp
     e7c:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     e7e:	8b 45 10             	mov    0x10(%ebp),%eax
     e81:	50                   	push   %eax
     e82:	ff 75 0c             	pushl  0xc(%ebp)
     e85:	ff 75 08             	pushl  0x8(%ebp)
     e88:	e8 32 ff ff ff       	call   dbf <stosb>
     e8d:	83 c4 0c             	add    $0xc,%esp
  return dst;
     e90:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e93:	c9                   	leave  
     e94:	c3                   	ret    

00000e95 <strchr>:

char*
strchr(const char *s, char c)
{
     e95:	55                   	push   %ebp
     e96:	89 e5                	mov    %esp,%ebp
     e98:	83 ec 04             	sub    $0x4,%esp
     e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     ea1:	eb 14                	jmp    eb7 <strchr+0x22>
    if(*s == c)
     ea3:	8b 45 08             	mov    0x8(%ebp),%eax
     ea6:	0f b6 00             	movzbl (%eax),%eax
     ea9:	3a 45 fc             	cmp    -0x4(%ebp),%al
     eac:	75 05                	jne    eb3 <strchr+0x1e>
      return (char*)s;
     eae:	8b 45 08             	mov    0x8(%ebp),%eax
     eb1:	eb 13                	jmp    ec6 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     eb3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     eb7:	8b 45 08             	mov    0x8(%ebp),%eax
     eba:	0f b6 00             	movzbl (%eax),%eax
     ebd:	84 c0                	test   %al,%al
     ebf:	75 e2                	jne    ea3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     ec1:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ec6:	c9                   	leave  
     ec7:	c3                   	ret    

00000ec8 <gets>:

char*
gets(char *buf, int max)
{
     ec8:	55                   	push   %ebp
     ec9:	89 e5                	mov    %esp,%ebp
     ecb:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ece:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ed5:	eb 42                	jmp    f19 <gets+0x51>
    cc = read(0, &c, 1);
     ed7:	83 ec 04             	sub    $0x4,%esp
     eda:	6a 01                	push   $0x1
     edc:	8d 45 ef             	lea    -0x11(%ebp),%eax
     edf:	50                   	push   %eax
     ee0:	6a 00                	push   $0x0
     ee2:	e8 e1 02 00 00       	call   11c8 <read>
     ee7:	83 c4 10             	add    $0x10,%esp
     eea:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     eed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ef1:	7e 33                	jle    f26 <gets+0x5e>
      break;
    buf[i++] = c;
     ef3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef6:	8d 50 01             	lea    0x1(%eax),%edx
     ef9:	89 55 f4             	mov    %edx,-0xc(%ebp)
     efc:	89 c2                	mov    %eax,%edx
     efe:	8b 45 08             	mov    0x8(%ebp),%eax
     f01:	01 c2                	add    %eax,%edx
     f03:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f07:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     f09:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f0d:	3c 0a                	cmp    $0xa,%al
     f0f:	74 16                	je     f27 <gets+0x5f>
     f11:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f15:	3c 0d                	cmp    $0xd,%al
     f17:	74 0e                	je     f27 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f19:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f1c:	83 c0 01             	add    $0x1,%eax
     f1f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f22:	7c b3                	jl     ed7 <gets+0xf>
     f24:	eb 01                	jmp    f27 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     f26:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     f27:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f2a:	8b 45 08             	mov    0x8(%ebp),%eax
     f2d:	01 d0                	add    %edx,%eax
     f2f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     f32:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f35:	c9                   	leave  
     f36:	c3                   	ret    

00000f37 <stat>:

int
stat(char *n, struct stat *st)
{
     f37:	55                   	push   %ebp
     f38:	89 e5                	mov    %esp,%ebp
     f3a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f3d:	83 ec 08             	sub    $0x8,%esp
     f40:	6a 00                	push   $0x0
     f42:	ff 75 08             	pushl  0x8(%ebp)
     f45:	e8 a6 02 00 00       	call   11f0 <open>
     f4a:	83 c4 10             	add    $0x10,%esp
     f4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     f50:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f54:	79 07                	jns    f5d <stat+0x26>
    return -1;
     f56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     f5b:	eb 25                	jmp    f82 <stat+0x4b>
  r = fstat(fd, st);
     f5d:	83 ec 08             	sub    $0x8,%esp
     f60:	ff 75 0c             	pushl  0xc(%ebp)
     f63:	ff 75 f4             	pushl  -0xc(%ebp)
     f66:	e8 9d 02 00 00       	call   1208 <fstat>
     f6b:	83 c4 10             	add    $0x10,%esp
     f6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     f71:	83 ec 0c             	sub    $0xc,%esp
     f74:	ff 75 f4             	pushl  -0xc(%ebp)
     f77:	e8 5c 02 00 00       	call   11d8 <close>
     f7c:	83 c4 10             	add    $0x10,%esp
  return r;
     f7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     f82:	c9                   	leave  
     f83:	c3                   	ret    

00000f84 <atoi>:

int
atoi(const char *s)
{
     f84:	55                   	push   %ebp
     f85:	89 e5                	mov    %esp,%ebp
     f87:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     f8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     f91:	eb 25                	jmp    fb8 <atoi+0x34>
    n = n*10 + *s++ - '0';
     f93:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f96:	89 d0                	mov    %edx,%eax
     f98:	c1 e0 02             	shl    $0x2,%eax
     f9b:	01 d0                	add    %edx,%eax
     f9d:	01 c0                	add    %eax,%eax
     f9f:	89 c1                	mov    %eax,%ecx
     fa1:	8b 45 08             	mov    0x8(%ebp),%eax
     fa4:	8d 50 01             	lea    0x1(%eax),%edx
     fa7:	89 55 08             	mov    %edx,0x8(%ebp)
     faa:	0f b6 00             	movzbl (%eax),%eax
     fad:	0f be c0             	movsbl %al,%eax
     fb0:	01 c8                	add    %ecx,%eax
     fb2:	83 e8 30             	sub    $0x30,%eax
     fb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     fb8:	8b 45 08             	mov    0x8(%ebp),%eax
     fbb:	0f b6 00             	movzbl (%eax),%eax
     fbe:	3c 2f                	cmp    $0x2f,%al
     fc0:	7e 0a                	jle    fcc <atoi+0x48>
     fc2:	8b 45 08             	mov    0x8(%ebp),%eax
     fc5:	0f b6 00             	movzbl (%eax),%eax
     fc8:	3c 39                	cmp    $0x39,%al
     fca:	7e c7                	jle    f93 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     fcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     fcf:	c9                   	leave  
     fd0:	c3                   	ret    

00000fd1 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     fd1:	55                   	push   %ebp
     fd2:	89 e5                	mov    %esp,%ebp
     fd4:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     fd7:	8b 45 08             	mov    0x8(%ebp),%eax
     fda:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     fdd:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     fe3:	eb 17                	jmp    ffc <memmove+0x2b>
    *dst++ = *src++;
     fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fe8:	8d 50 01             	lea    0x1(%eax),%edx
     feb:	89 55 fc             	mov    %edx,-0x4(%ebp)
     fee:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ff1:	8d 4a 01             	lea    0x1(%edx),%ecx
     ff4:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     ff7:	0f b6 12             	movzbl (%edx),%edx
     ffa:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ffc:	8b 45 10             	mov    0x10(%ebp),%eax
     fff:	8d 50 ff             	lea    -0x1(%eax),%edx
    1002:	89 55 10             	mov    %edx,0x10(%ebp)
    1005:	85 c0                	test   %eax,%eax
    1007:	7f dc                	jg     fe5 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1009:	8b 45 08             	mov    0x8(%ebp),%eax
}
    100c:	c9                   	leave  
    100d:	c3                   	ret    

0000100e <historyAdd>:

void
historyAdd(char *buf1){
    100e:	55                   	push   %ebp
    100f:	89 e5                	mov    %esp,%ebp
    1011:	53                   	push   %ebx
    1012:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
    1018:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
    101f:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
    1026:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
    102c:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
    1030:	83 ec 08             	sub    $0x8,%esp
    1033:	6a 00                	push   $0x0
    1035:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1038:	50                   	push   %eax
    1039:	e8 b2 01 00 00       	call   11f0 <open>
    103e:	83 c4 10             	add    $0x10,%esp
    1041:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1044:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1048:	79 1b                	jns    1065 <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
    104a:	83 ec 04             	sub    $0x4,%esp
    104d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1050:	50                   	push   %eax
    1051:	68 e4 17 00 00       	push   $0x17e4
    1056:	6a 01                	push   $0x1
    1058:	e8 ca 02 00 00       	call   1327 <printf>
    105d:	83 c4 10             	add    $0x10,%esp
       exit();
    1060:	e8 4b 01 00 00       	call   11b0 <exit>
     }

     int i=0;
    1065:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
    106c:	eb 1c                	jmp    108a <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
    106e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1071:	8b 45 08             	mov    0x8(%ebp),%eax
    1074:	01 d0                	add    %edx,%eax
    1076:	0f b6 00             	movzbl (%eax),%eax
    1079:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
    107f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1082:	01 ca                	add    %ecx,%edx
    1084:	88 02                	mov    %al,(%edx)
	i++;
    1086:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
    108a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    108d:	8b 45 08             	mov    0x8(%ebp),%eax
    1090:	01 d0                	add    %edx,%eax
    1092:	0f b6 00             	movzbl (%eax),%eax
    1095:	84 c0                	test   %al,%al
    1097:	75 d5                	jne    106e <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    1099:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
    109f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10a2:	01 d0                	add    %edx,%eax
    10a4:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
    10a7:	eb 5a                	jmp    1103 <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
    10a9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    10ac:	83 ec 0c             	sub    $0xc,%esp
    10af:	ff 75 08             	pushl  0x8(%ebp)
    10b2:	e8 9d fd ff ff       	call   e54 <strlen>
    10b7:	83 c4 10             	add    $0x10,%esp
    10ba:	29 c3                	sub    %eax,%ebx
    10bc:	89 d8                	mov    %ebx,%eax
    10be:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
    10c5:	ff 
    10c6:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
    10cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10cf:	01 ca                	add    %ecx,%edx
    10d1:	88 02                	mov    %al,(%edx)
		i++;
    10d3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
    10d7:	83 ec 0c             	sub    $0xc,%esp
    10da:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
    10e0:	50                   	push   %eax
    10e1:	e8 6e fd ff ff       	call   e54 <strlen>
    10e6:	83 c4 10             	add    $0x10,%esp
    10e9:	89 c3                	mov    %eax,%ebx
    10eb:	83 ec 0c             	sub    $0xc,%esp
    10ee:	ff 75 08             	pushl  0x8(%ebp)
    10f1:	e8 5e fd ff ff       	call   e54 <strlen>
    10f6:	83 c4 10             	add    $0x10,%esp
    10f9:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    10fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ff:	39 c2                	cmp    %eax,%edx
    1101:	77 a6                	ja     10a9 <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
    1103:	83 ec 04             	sub    $0x4,%esp
    1106:	68 e8 03 00 00       	push   $0x3e8
    110b:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
    1111:	50                   	push   %eax
    1112:	ff 75 f0             	pushl  -0x10(%ebp)
    1115:	e8 ae 00 00 00       	call   11c8 <read>
    111a:	83 c4 10             	add    $0x10,%esp
    111d:	85 c0                	test   %eax,%eax
    111f:	7f b6                	jg     10d7 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
    1121:	83 ec 0c             	sub    $0xc,%esp
    1124:	ff 75 f0             	pushl  -0x10(%ebp)
    1127:	e8 ac 00 00 00       	call   11d8 <close>
    112c:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
    112f:	83 ec 08             	sub    $0x8,%esp
    1132:	68 02 02 00 00       	push   $0x202
    1137:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    113a:	50                   	push   %eax
    113b:	e8 b0 00 00 00       	call   11f0 <open>
    1140:	83 c4 10             	add    $0x10,%esp
    1143:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1146:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    114a:	79 1b                	jns    1167 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
    114c:	83 ec 04             	sub    $0x4,%esp
    114f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1152:	50                   	push   %eax
    1153:	68 e4 17 00 00       	push   $0x17e4
    1158:	6a 01                	push   $0x1
    115a:	e8 c8 01 00 00       	call   1327 <printf>
    115f:	83 c4 10             	add    $0x10,%esp
       exit();
    1162:	e8 49 00 00 00       	call   11b0 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
    1167:	83 ec 04             	sub    $0x4,%esp
    116a:	68 e8 03 00 00       	push   $0x3e8
    116f:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
    1175:	50                   	push   %eax
    1176:	ff 75 f0             	pushl  -0x10(%ebp)
    1179:	e8 52 00 00 00       	call   11d0 <write>
    117e:	83 c4 10             	add    $0x10,%esp
    1181:	3d e8 03 00 00       	cmp    $0x3e8,%eax
    1186:	74 1a                	je     11a2 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
    1188:	83 ec 04             	sub    $0x4,%esp
    118b:	ff 75 f4             	pushl  -0xc(%ebp)
    118e:	68 00 18 00 00       	push   $0x1800
    1193:	6a 01                	push   $0x1
    1195:	e8 8d 01 00 00       	call   1327 <printf>
    119a:	83 c4 10             	add    $0x10,%esp
       exit();
    119d:	e8 0e 00 00 00       	call   11b0 <exit>
     }
    
}
    11a2:	90                   	nop
    11a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11a6:	c9                   	leave  
    11a7:	c3                   	ret    

000011a8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11a8:	b8 01 00 00 00       	mov    $0x1,%eax
    11ad:	cd 40                	int    $0x40
    11af:	c3                   	ret    

000011b0 <exit>:
SYSCALL(exit)
    11b0:	b8 02 00 00 00       	mov    $0x2,%eax
    11b5:	cd 40                	int    $0x40
    11b7:	c3                   	ret    

000011b8 <wait>:
SYSCALL(wait)
    11b8:	b8 03 00 00 00       	mov    $0x3,%eax
    11bd:	cd 40                	int    $0x40
    11bf:	c3                   	ret    

000011c0 <pipe>:
SYSCALL(pipe)
    11c0:	b8 04 00 00 00       	mov    $0x4,%eax
    11c5:	cd 40                	int    $0x40
    11c7:	c3                   	ret    

000011c8 <read>:
SYSCALL(read)
    11c8:	b8 05 00 00 00       	mov    $0x5,%eax
    11cd:	cd 40                	int    $0x40
    11cf:	c3                   	ret    

000011d0 <write>:
SYSCALL(write)
    11d0:	b8 10 00 00 00       	mov    $0x10,%eax
    11d5:	cd 40                	int    $0x40
    11d7:	c3                   	ret    

000011d8 <close>:
SYSCALL(close)
    11d8:	b8 15 00 00 00       	mov    $0x15,%eax
    11dd:	cd 40                	int    $0x40
    11df:	c3                   	ret    

000011e0 <kill>:
SYSCALL(kill)
    11e0:	b8 06 00 00 00       	mov    $0x6,%eax
    11e5:	cd 40                	int    $0x40
    11e7:	c3                   	ret    

000011e8 <exec>:
SYSCALL(exec)
    11e8:	b8 07 00 00 00       	mov    $0x7,%eax
    11ed:	cd 40                	int    $0x40
    11ef:	c3                   	ret    

000011f0 <open>:
SYSCALL(open)
    11f0:	b8 0f 00 00 00       	mov    $0xf,%eax
    11f5:	cd 40                	int    $0x40
    11f7:	c3                   	ret    

000011f8 <mknod>:
SYSCALL(mknod)
    11f8:	b8 11 00 00 00       	mov    $0x11,%eax
    11fd:	cd 40                	int    $0x40
    11ff:	c3                   	ret    

00001200 <unlink>:
SYSCALL(unlink)
    1200:	b8 12 00 00 00       	mov    $0x12,%eax
    1205:	cd 40                	int    $0x40
    1207:	c3                   	ret    

00001208 <fstat>:
SYSCALL(fstat)
    1208:	b8 08 00 00 00       	mov    $0x8,%eax
    120d:	cd 40                	int    $0x40
    120f:	c3                   	ret    

00001210 <link>:
SYSCALL(link)
    1210:	b8 13 00 00 00       	mov    $0x13,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    

00001218 <mkdir>:
SYSCALL(mkdir)
    1218:	b8 14 00 00 00       	mov    $0x14,%eax
    121d:	cd 40                	int    $0x40
    121f:	c3                   	ret    

00001220 <chdir>:
SYSCALL(chdir)
    1220:	b8 09 00 00 00       	mov    $0x9,%eax
    1225:	cd 40                	int    $0x40
    1227:	c3                   	ret    

00001228 <dup>:
SYSCALL(dup)
    1228:	b8 0a 00 00 00       	mov    $0xa,%eax
    122d:	cd 40                	int    $0x40
    122f:	c3                   	ret    

00001230 <getpid>:
SYSCALL(getpid)
    1230:	b8 0b 00 00 00       	mov    $0xb,%eax
    1235:	cd 40                	int    $0x40
    1237:	c3                   	ret    

00001238 <sbrk>:
SYSCALL(sbrk)
    1238:	b8 0c 00 00 00       	mov    $0xc,%eax
    123d:	cd 40                	int    $0x40
    123f:	c3                   	ret    

00001240 <sleep>:
SYSCALL(sleep)
    1240:	b8 0d 00 00 00       	mov    $0xd,%eax
    1245:	cd 40                	int    $0x40
    1247:	c3                   	ret    

00001248 <uptime>:
SYSCALL(uptime)
    1248:	b8 0e 00 00 00       	mov    $0xe,%eax
    124d:	cd 40                	int    $0x40
    124f:	c3                   	ret    

00001250 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	83 ec 18             	sub    $0x18,%esp
    1256:	8b 45 0c             	mov    0xc(%ebp),%eax
    1259:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    125c:	83 ec 04             	sub    $0x4,%esp
    125f:	6a 01                	push   $0x1
    1261:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1264:	50                   	push   %eax
    1265:	ff 75 08             	pushl  0x8(%ebp)
    1268:	e8 63 ff ff ff       	call   11d0 <write>
    126d:	83 c4 10             	add    $0x10,%esp
}
    1270:	90                   	nop
    1271:	c9                   	leave  
    1272:	c3                   	ret    

00001273 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1273:	55                   	push   %ebp
    1274:	89 e5                	mov    %esp,%ebp
    1276:	53                   	push   %ebx
    1277:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    127a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1281:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1285:	74 17                	je     129e <printint+0x2b>
    1287:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    128b:	79 11                	jns    129e <printint+0x2b>
    neg = 1;
    128d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1294:	8b 45 0c             	mov    0xc(%ebp),%eax
    1297:	f7 d8                	neg    %eax
    1299:	89 45 ec             	mov    %eax,-0x14(%ebp)
    129c:	eb 06                	jmp    12a4 <printint+0x31>
  } else {
    x = xx;
    129e:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    12a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    12ab:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12ae:	8d 41 01             	lea    0x1(%ecx),%eax
    12b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12b4:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12ba:	ba 00 00 00 00       	mov    $0x0,%edx
    12bf:	f7 f3                	div    %ebx
    12c1:	89 d0                	mov    %edx,%eax
    12c3:	0f b6 80 04 1d 00 00 	movzbl 0x1d04(%eax),%eax
    12ca:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    12ce:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12d4:	ba 00 00 00 00       	mov    $0x0,%edx
    12d9:	f7 f3                	div    %ebx
    12db:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12de:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12e2:	75 c7                	jne    12ab <printint+0x38>
  if(neg)
    12e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12e8:	74 2d                	je     1317 <printint+0xa4>
    buf[i++] = '-';
    12ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12ed:	8d 50 01             	lea    0x1(%eax),%edx
    12f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
    12f3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    12f8:	eb 1d                	jmp    1317 <printint+0xa4>
    putc(fd, buf[i]);
    12fa:	8d 55 dc             	lea    -0x24(%ebp),%edx
    12fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1300:	01 d0                	add    %edx,%eax
    1302:	0f b6 00             	movzbl (%eax),%eax
    1305:	0f be c0             	movsbl %al,%eax
    1308:	83 ec 08             	sub    $0x8,%esp
    130b:	50                   	push   %eax
    130c:	ff 75 08             	pushl  0x8(%ebp)
    130f:	e8 3c ff ff ff       	call   1250 <putc>
    1314:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1317:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    131b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    131f:	79 d9                	jns    12fa <printint+0x87>
    putc(fd, buf[i]);
}
    1321:	90                   	nop
    1322:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1325:	c9                   	leave  
    1326:	c3                   	ret    

00001327 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1327:	55                   	push   %ebp
    1328:	89 e5                	mov    %esp,%ebp
    132a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    132d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1334:	8d 45 0c             	lea    0xc(%ebp),%eax
    1337:	83 c0 04             	add    $0x4,%eax
    133a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    133d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1344:	e9 59 01 00 00       	jmp    14a2 <printf+0x17b>
    c = fmt[i] & 0xff;
    1349:	8b 55 0c             	mov    0xc(%ebp),%edx
    134c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    134f:	01 d0                	add    %edx,%eax
    1351:	0f b6 00             	movzbl (%eax),%eax
    1354:	0f be c0             	movsbl %al,%eax
    1357:	25 ff 00 00 00       	and    $0xff,%eax
    135c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    135f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1363:	75 2c                	jne    1391 <printf+0x6a>
      if(c == '%'){
    1365:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1369:	75 0c                	jne    1377 <printf+0x50>
        state = '%';
    136b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1372:	e9 27 01 00 00       	jmp    149e <printf+0x177>
      } else {
        putc(fd, c);
    1377:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    137a:	0f be c0             	movsbl %al,%eax
    137d:	83 ec 08             	sub    $0x8,%esp
    1380:	50                   	push   %eax
    1381:	ff 75 08             	pushl  0x8(%ebp)
    1384:	e8 c7 fe ff ff       	call   1250 <putc>
    1389:	83 c4 10             	add    $0x10,%esp
    138c:	e9 0d 01 00 00       	jmp    149e <printf+0x177>
      }
    } else if(state == '%'){
    1391:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1395:	0f 85 03 01 00 00    	jne    149e <printf+0x177>
      if(c == 'd'){
    139b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    139f:	75 1e                	jne    13bf <printf+0x98>
        printint(fd, *ap, 10, 1);
    13a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13a4:	8b 00                	mov    (%eax),%eax
    13a6:	6a 01                	push   $0x1
    13a8:	6a 0a                	push   $0xa
    13aa:	50                   	push   %eax
    13ab:	ff 75 08             	pushl  0x8(%ebp)
    13ae:	e8 c0 fe ff ff       	call   1273 <printint>
    13b3:	83 c4 10             	add    $0x10,%esp
        ap++;
    13b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    13ba:	e9 d8 00 00 00       	jmp    1497 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    13bf:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    13c3:	74 06                	je     13cb <printf+0xa4>
    13c5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    13c9:	75 1e                	jne    13e9 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    13cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13ce:	8b 00                	mov    (%eax),%eax
    13d0:	6a 00                	push   $0x0
    13d2:	6a 10                	push   $0x10
    13d4:	50                   	push   %eax
    13d5:	ff 75 08             	pushl  0x8(%ebp)
    13d8:	e8 96 fe ff ff       	call   1273 <printint>
    13dd:	83 c4 10             	add    $0x10,%esp
        ap++;
    13e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    13e4:	e9 ae 00 00 00       	jmp    1497 <printf+0x170>
      } else if(c == 's'){
    13e9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    13ed:	75 43                	jne    1432 <printf+0x10b>
        s = (char*)*ap;
    13ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13f2:	8b 00                	mov    (%eax),%eax
    13f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    13f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    13fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13ff:	75 25                	jne    1426 <printf+0xff>
          s = "(null)";
    1401:	c7 45 f4 24 18 00 00 	movl   $0x1824,-0xc(%ebp)
        while(*s != 0){
    1408:	eb 1c                	jmp    1426 <printf+0xff>
          putc(fd, *s);
    140a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140d:	0f b6 00             	movzbl (%eax),%eax
    1410:	0f be c0             	movsbl %al,%eax
    1413:	83 ec 08             	sub    $0x8,%esp
    1416:	50                   	push   %eax
    1417:	ff 75 08             	pushl  0x8(%ebp)
    141a:	e8 31 fe ff ff       	call   1250 <putc>
    141f:	83 c4 10             	add    $0x10,%esp
          s++;
    1422:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1429:	0f b6 00             	movzbl (%eax),%eax
    142c:	84 c0                	test   %al,%al
    142e:	75 da                	jne    140a <printf+0xe3>
    1430:	eb 65                	jmp    1497 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1432:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1436:	75 1d                	jne    1455 <printf+0x12e>
        putc(fd, *ap);
    1438:	8b 45 e8             	mov    -0x18(%ebp),%eax
    143b:	8b 00                	mov    (%eax),%eax
    143d:	0f be c0             	movsbl %al,%eax
    1440:	83 ec 08             	sub    $0x8,%esp
    1443:	50                   	push   %eax
    1444:	ff 75 08             	pushl  0x8(%ebp)
    1447:	e8 04 fe ff ff       	call   1250 <putc>
    144c:	83 c4 10             	add    $0x10,%esp
        ap++;
    144f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1453:	eb 42                	jmp    1497 <printf+0x170>
      } else if(c == '%'){
    1455:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1459:	75 17                	jne    1472 <printf+0x14b>
        putc(fd, c);
    145b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    145e:	0f be c0             	movsbl %al,%eax
    1461:	83 ec 08             	sub    $0x8,%esp
    1464:	50                   	push   %eax
    1465:	ff 75 08             	pushl  0x8(%ebp)
    1468:	e8 e3 fd ff ff       	call   1250 <putc>
    146d:	83 c4 10             	add    $0x10,%esp
    1470:	eb 25                	jmp    1497 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1472:	83 ec 08             	sub    $0x8,%esp
    1475:	6a 25                	push   $0x25
    1477:	ff 75 08             	pushl  0x8(%ebp)
    147a:	e8 d1 fd ff ff       	call   1250 <putc>
    147f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1482:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1485:	0f be c0             	movsbl %al,%eax
    1488:	83 ec 08             	sub    $0x8,%esp
    148b:	50                   	push   %eax
    148c:	ff 75 08             	pushl  0x8(%ebp)
    148f:	e8 bc fd ff ff       	call   1250 <putc>
    1494:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1497:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    149e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14a2:	8b 55 0c             	mov    0xc(%ebp),%edx
    14a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14a8:	01 d0                	add    %edx,%eax
    14aa:	0f b6 00             	movzbl (%eax),%eax
    14ad:	84 c0                	test   %al,%al
    14af:	0f 85 94 fe ff ff    	jne    1349 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14b5:	90                   	nop
    14b6:	c9                   	leave  
    14b7:	c3                   	ret    

000014b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b8:	55                   	push   %ebp
    14b9:	89 e5                	mov    %esp,%ebp
    14bb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14be:	8b 45 08             	mov    0x8(%ebp),%eax
    14c1:	83 e8 08             	sub    $0x8,%eax
    14c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c7:	a1 8c 1d 00 00       	mov    0x1d8c,%eax
    14cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14cf:	eb 24                	jmp    14f5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14d4:	8b 00                	mov    (%eax),%eax
    14d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14d9:	77 12                	ja     14ed <free+0x35>
    14db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14e1:	77 24                	ja     1507 <free+0x4f>
    14e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14e6:	8b 00                	mov    (%eax),%eax
    14e8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14eb:	77 1a                	ja     1507 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14f0:	8b 00                	mov    (%eax),%eax
    14f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14f8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14fb:	76 d4                	jbe    14d1 <free+0x19>
    14fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1500:	8b 00                	mov    (%eax),%eax
    1502:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1505:	76 ca                	jbe    14d1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1507:	8b 45 f8             	mov    -0x8(%ebp),%eax
    150a:	8b 40 04             	mov    0x4(%eax),%eax
    150d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1514:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1517:	01 c2                	add    %eax,%edx
    1519:	8b 45 fc             	mov    -0x4(%ebp),%eax
    151c:	8b 00                	mov    (%eax),%eax
    151e:	39 c2                	cmp    %eax,%edx
    1520:	75 24                	jne    1546 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1522:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1525:	8b 50 04             	mov    0x4(%eax),%edx
    1528:	8b 45 fc             	mov    -0x4(%ebp),%eax
    152b:	8b 00                	mov    (%eax),%eax
    152d:	8b 40 04             	mov    0x4(%eax),%eax
    1530:	01 c2                	add    %eax,%edx
    1532:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1535:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1538:	8b 45 fc             	mov    -0x4(%ebp),%eax
    153b:	8b 00                	mov    (%eax),%eax
    153d:	8b 10                	mov    (%eax),%edx
    153f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1542:	89 10                	mov    %edx,(%eax)
    1544:	eb 0a                	jmp    1550 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1546:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1549:	8b 10                	mov    (%eax),%edx
    154b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    154e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1550:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1553:	8b 40 04             	mov    0x4(%eax),%eax
    1556:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    155d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1560:	01 d0                	add    %edx,%eax
    1562:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1565:	75 20                	jne    1587 <free+0xcf>
    p->s.size += bp->s.size;
    1567:	8b 45 fc             	mov    -0x4(%ebp),%eax
    156a:	8b 50 04             	mov    0x4(%eax),%edx
    156d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1570:	8b 40 04             	mov    0x4(%eax),%eax
    1573:	01 c2                	add    %eax,%edx
    1575:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1578:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    157b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    157e:	8b 10                	mov    (%eax),%edx
    1580:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1583:	89 10                	mov    %edx,(%eax)
    1585:	eb 08                	jmp    158f <free+0xd7>
  } else
    p->s.ptr = bp;
    1587:	8b 45 fc             	mov    -0x4(%ebp),%eax
    158a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    158d:	89 10                	mov    %edx,(%eax)
  freep = p;
    158f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1592:	a3 8c 1d 00 00       	mov    %eax,0x1d8c
}
    1597:	90                   	nop
    1598:	c9                   	leave  
    1599:	c3                   	ret    

0000159a <morecore>:

static Header*
morecore(uint nu)
{
    159a:	55                   	push   %ebp
    159b:	89 e5                	mov    %esp,%ebp
    159d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    15a0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    15a7:	77 07                	ja     15b0 <morecore+0x16>
    nu = 4096;
    15a9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    15b0:	8b 45 08             	mov    0x8(%ebp),%eax
    15b3:	c1 e0 03             	shl    $0x3,%eax
    15b6:	83 ec 0c             	sub    $0xc,%esp
    15b9:	50                   	push   %eax
    15ba:	e8 79 fc ff ff       	call   1238 <sbrk>
    15bf:	83 c4 10             	add    $0x10,%esp
    15c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    15c5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    15c9:	75 07                	jne    15d2 <morecore+0x38>
    return 0;
    15cb:	b8 00 00 00 00       	mov    $0x0,%eax
    15d0:	eb 26                	jmp    15f8 <morecore+0x5e>
  hp = (Header*)p;
    15d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    15d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15db:	8b 55 08             	mov    0x8(%ebp),%edx
    15de:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    15e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e4:	83 c0 08             	add    $0x8,%eax
    15e7:	83 ec 0c             	sub    $0xc,%esp
    15ea:	50                   	push   %eax
    15eb:	e8 c8 fe ff ff       	call   14b8 <free>
    15f0:	83 c4 10             	add    $0x10,%esp
  return freep;
    15f3:	a1 8c 1d 00 00       	mov    0x1d8c,%eax
}
    15f8:	c9                   	leave  
    15f9:	c3                   	ret    

000015fa <malloc>:

void*
malloc(uint nbytes)
{
    15fa:	55                   	push   %ebp
    15fb:	89 e5                	mov    %esp,%ebp
    15fd:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
    1603:	83 c0 07             	add    $0x7,%eax
    1606:	c1 e8 03             	shr    $0x3,%eax
    1609:	83 c0 01             	add    $0x1,%eax
    160c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    160f:	a1 8c 1d 00 00       	mov    0x1d8c,%eax
    1614:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1617:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    161b:	75 23                	jne    1640 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    161d:	c7 45 f0 84 1d 00 00 	movl   $0x1d84,-0x10(%ebp)
    1624:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1627:	a3 8c 1d 00 00       	mov    %eax,0x1d8c
    162c:	a1 8c 1d 00 00       	mov    0x1d8c,%eax
    1631:	a3 84 1d 00 00       	mov    %eax,0x1d84
    base.s.size = 0;
    1636:	c7 05 88 1d 00 00 00 	movl   $0x0,0x1d88
    163d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1640:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1643:	8b 00                	mov    (%eax),%eax
    1645:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1648:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164b:	8b 40 04             	mov    0x4(%eax),%eax
    164e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1651:	72 4d                	jb     16a0 <malloc+0xa6>
      if(p->s.size == nunits)
    1653:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1656:	8b 40 04             	mov    0x4(%eax),%eax
    1659:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    165c:	75 0c                	jne    166a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1661:	8b 10                	mov    (%eax),%edx
    1663:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1666:	89 10                	mov    %edx,(%eax)
    1668:	eb 26                	jmp    1690 <malloc+0x96>
      else {
        p->s.size -= nunits;
    166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166d:	8b 40 04             	mov    0x4(%eax),%eax
    1670:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1673:	89 c2                	mov    %eax,%edx
    1675:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1678:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    167b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167e:	8b 40 04             	mov    0x4(%eax),%eax
    1681:	c1 e0 03             	shl    $0x3,%eax
    1684:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1687:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    168d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1690:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1693:	a3 8c 1d 00 00       	mov    %eax,0x1d8c
      return (void*)(p + 1);
    1698:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169b:	83 c0 08             	add    $0x8,%eax
    169e:	eb 3b                	jmp    16db <malloc+0xe1>
    }
    if(p == freep)
    16a0:	a1 8c 1d 00 00       	mov    0x1d8c,%eax
    16a5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    16a8:	75 1e                	jne    16c8 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    16aa:	83 ec 0c             	sub    $0xc,%esp
    16ad:	ff 75 ec             	pushl  -0x14(%ebp)
    16b0:	e8 e5 fe ff ff       	call   159a <morecore>
    16b5:	83 c4 10             	add    $0x10,%esp
    16b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16bf:	75 07                	jne    16c8 <malloc+0xce>
        return 0;
    16c1:	b8 00 00 00 00       	mov    $0x0,%eax
    16c6:	eb 13                	jmp    16db <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    16ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d1:	8b 00                	mov    (%eax),%eax
    16d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    16d6:	e9 6d ff ff ff       	jmp    1648 <malloc+0x4e>
}
    16db:	c9                   	leave  
    16dc:	c3                   	ret    
