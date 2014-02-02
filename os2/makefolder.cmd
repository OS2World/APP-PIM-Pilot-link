/* Recreate objects script.
 *
 * Generated via Object Desktop Package File 'Object Package'.
 */

/* Register with REXX API extensions. */
Call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
Call SysLoadFuncs

CreateCollision = 'Update'

Call SysCls

/* Get COM port. */
Say ' '
Say 'Create Pilot-Link for OS/2 folder and icons.'
Say
Say 'NOTE: This program needs to be executed from the OS2 subdirectory'
Say '      of your working setup.'
Say ' '
Say 'COM port Pilot cradle is connected to:'
/* 
Say 'NOTE: Without colon.'
Call CharOut, '  (COM1,COM2,COM3,COM4,etc) : '
Parse Upper Pull COMport 
*/
Say '   USB port only'
COMport = '-p usb:'

Say ' '
Say 'Mail Sync:'
Say 'NOTE: Leaving any of the following values blank will cause the'
Say '      icon to prompt for the value each time it is executed.'
Call CharOut, '  POP Server: '
Parse Pull POPServer
Call CharOut, '  POP Username: '
Parse Pull POPUser
Call CharOut, '  POP Password: '
Parse Pull POPPassword
Call CharOut, '  E-Mail from address: '
Parse Pull POPFrom
Call CharOut, '  Disposition of received mail(KEEP/delete): '
Parse Pull POPReceived
Call CharOut, '  Disposition of sent mail(keep/delete/FILE): '
Parse Pull POPSent
Say ' '
Say 'PMMail Mail Sync:'
Call CharOut, '  Path to PMMail account directory(ie. \pmmail\?????.ACT): '
Parse Pull PMMailPath
Call CharOut, '  PMMail Name(ie. John Smith): '
Parse Pull PMMailName
Say ' '
/*
Say 'Pilot PPP Server:'
Call CharOut, '  PPP Port IP address(10.1.0.1): '
Parse Pull PPPIP
Call CharOut, '  Pilot IP address(10.1.0.2): '
Parse Pull PilotIP
Say ' '
*/

Call CreateObjects
Exit

CreateObject: procedure
    Parse Arg Class, Title, Location, Setup, Collision
    Say 'Creating ['Title']'
    rc = SysCreateObject( Class, Title, Location, Setup, Collision )
    If rc <> 1 Then
        Say ' > failed to create ['Title' | 'Class'] at location ['Location']'
    return rc

CreateObjects:

/* Figure out the directories involved. */
current_dir = directory()
previous_dir = left(current_dir, ( length(current_dir) - 4 ))
bin_dir = previous_dir || '\bin'
folder_id = '<Pilot_Link>'
folder_name = 'Pilot-Link'

  rc = CreateObject( 'WPFolder',,
    folder_name,,
    '<WP_DESKTOP>',,
    'NOTDEFAULTICON=YES;'||,
        'NOPRINT=YES;'||,
        'DEFAULTVIEW=CONTENTS;'||,
        'SELFCLOSE=1;'||,
        'ALWAYSSORT=YES;'||,
        'OBJECTID='||folder_id,,
    CreateCollision )

  rc = CreateObject( 'WPShadow',,
      'ChangeLog',,
      folder_id,,
      'SHADOWID='||bin_dir||'\ChangeLog',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Get ROM: Install PRC^(Required to use Get ROM)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-XFER.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -i "getrom.prc";'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Backup Pilot^(Complete)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-XFER.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -b [Destination path for Pilot Backup:];'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\Backup.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Backup Pilot^(Update)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-XFER.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -u [Destination path for Pilot Backup:];'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\Backup.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Backup Pilot^(Sync)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-XFER.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -s [Destination path for Pilot Backup:];'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\Backup.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'List Pilot Files',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME=CMD.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS=/C '||bin_dir||'\PILOT-XFER.EXE '||COMport||' -l |more;'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\ListFiles.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Get Clipboard^from Pilot',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-CLIP.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -g;'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\GetClip.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'User Information',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\install-user.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||';'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\UserInfo.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Install PRC or PDB^(Droped on me)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-XFER.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -i "%*";'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\InstallPRC.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPShadow',,
      'README',,
      folder_id,,
      'SHADOWID='||previous_dir||'\README',,
      CreateCollision )

  rc = CreateObject( 'WPShadow',,
      'README.TXT',,
      folder_id,,
      'SHADOWID='||previous_dir||'\README.TXT',,
      CreateCollision )

  rc = CreateObject( 'WPShadow',,
      'COPYING',,
      folder_id,,
      'SHADOWID='||previous_dir||'\COPYING',,
      CreateCollision )

  rc = CreateObject( 'WPShadow',,
      'NEWS',,
      folder_id,,
      'SHADOWID='||previous_dir||'\NEWS',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Get ROM',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\GETROM.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||';'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Restore Pilot',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-XFER.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -r [Full path to restore Pilot from:];'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\Restore.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Install PRC or  PDB^(Prompts for file)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-XFER.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -i "[Full pathname to PRC or PDB]";'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\InstallPRC.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'DLP Shell',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\DLPSH.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||';'||,
          'PROGTYPE=WINDOWABLEVIO',,
      CreateCollision )

  rc = CreateObject( 'WPShadow',,
      'COPYING',,
      folder_id,,
      'SHADOWID='||bin_dir||'\COPYING',,
      CreateCollision )

  rc = CreateObject( 'WPShadow',,
      'TODO',,
      folder_id,,
      'SHADOWID='||bin_dir||'\TODO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Install File to MemoPad^(Prompts for file path)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\INSTALL-MEMO.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' [File to Install into MemoPad on Pilot:];'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\InstallMemo.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Install File to MemoPad^(Droped on me)',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\INSTALL-MEMO.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' "%*";'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\InstallMemo.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPFolder',,
    'Schlep',,
    folder_id,,
    'NOTDEFAULTICON=YES;'||,
        'NOPRINT=YES;'||,
        'DEFAULTVIEW=CONTENTS;'||,
        'SELFCLOSE=1;'||,
        'ALWAYSSORT=YES;'||,
        'OBJECTID=<Pilot_Link_Schlep>',,
    CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Schlep: Store File to Pilot^(Prompts for file path)',,
      '<Pilot_Link_Schlep>',,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME=CMD.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS=/C '||bin_dir||'\PILOT-SCHLEP.EXE '||COMport||' -i < [Path of File to Store on Pilot:];'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Schlep: Store File to Pilot^(Droped on me)',,
      '<Pilot_Link_Schlep>',,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME=CMD.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS=/C '||bin_dir||'\PILOT-SCHLEP.EXE '||COMport||' -i < "%*";'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Schlep: Get File Stored on Pilot^(Prompts for file path)',,
      '<Pilot_Link_Schlep>',,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME=CMD.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS=/C '||bin_dir||'\PILOT-SCHLEP.EXE '||COMport||' -f > [Path of File to Store File from Pilot To:];'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Schlep: Display File Stored on Pilot^(Displays file to screen)',,
      '<Pilot_Link_Schlep>',,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME=CMD.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS=/C '||bin_dir||'\PILOT-SCHLEP.EXE '||COMport||' -f | more;'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\ListFiles.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPProgram',,
      'Schlep: Delete File Stored on Pilot',,
      '<Pilot_Link_Schlep>',,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-SCHLEP.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' -d;'||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\Delete.ICO',,
      CreateCollision )

  parameters = 'PARAMETERS= -p'||COMport||' -h'
  if POPServer = '' then
    parameters = parameters||'[POP Server:] '
  else
    parameters = parameters||POPServer||' '
  parameters = parameters||'-u'
  if POPUser = '' then
    parameters = parameters||'[POP Username:] '
  else
    parameters = parameters||POPUser||' '
  parameters = parameters||'-P'
  if POPPassword = '' then
    parameters = parameters||'[POP Password:] '
  else
    parameters = parameters||POPPassword||' '
  parameters = parameters||'-f'
  if POPFrom = '' then
    parameters = parameters||'[E-Mail from address:] '
  else
    parameters = parameters||POPFrom||' '
  parameters = parameters||'-k'
  if POPReceived = '' then
    parameters = parameters||'keep '
  else
    parameters = parameters||POPReceived||' '
  parameters = parameters||'-d'
  if POPSent = '' then
    parameters = parameters||'file;'
  else
    parameters = parameters||POPSent||';'

  rc = CreateObject( 'WPProgram',,
      'Mail Sync^using Sendmail',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-MAIL.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          parameters||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\MailSync.ICO',,
      CreateCollision )

  /* PMMail option */
  /* pilot-mail -p com2 -s "pilotmail \pmmail\?????.ACT \"Your name\" someone@somewhere.com" -d file */
  parameters = 'PARAMETERS= -p'||COMport||' -h'
  if POPServer = '' then
    parameters = parameters||'[POP Server:] '
  else
    parameters = parameters||POPServer||' '
  parameters = parameters||'-u'
  if POPUser = '' then
    parameters = parameters||'[POP Username:] '
  else
    parameters = parameters||POPUser||' '
  parameters = parameters||'-P'
  if POPPassword = '' then
    parameters = parameters||'[POP Password:] '
  else
    parameters = parameters||POPPassword||' '
  parameters = parameters||'-f'
  if POPFrom = '' then
    parameters = parameters||'[E-Mail from address:] '
  else
    parameters = parameters||POPFrom||' '
  parameters = parameters||'-k'
  if POPReceived = '' then
    parameters = parameters||'keep '
  else
    parameters = parameters||POPReceived||' '
  parameters = parameters||'-d'
  if POPSent = '' then
    parameters = parameters||'file '
  else
    parameters = parameters||POPSent||' '
  parameters = parameters||'-s "'||bin_dir||'\pilotpmmail.exe '
  if PMMailPath = '' then
    parameters = parameters||'[PMMail Account Path:] '
  else
    parameters = parameters||PMMailPath||' '
  if PMMailName = '' then
    parameters = parameters||'\"[PMMail Name:]\"'
  else
    parameters = parameters||'\"'||PMMailName||'\" '
  if POPFrom = '' then
    parameters = parameters||'[E-Mail from address:]"'
  else
    parameters = parameters||POPFrom||'"'
  parameters = parameters||';'

  rc = CreateObject( 'WPProgram',,
      'Mail Sync^using PMMail',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME='||bin_dir||'\PILOT-MAIL.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          parameters||,
          'PROGTYPE=WINDOWABLEVIO;'||,
          'NOAUTOCLOSE=YES;'||,
          'ICONFILE='||current_dir||'\icons\MailSync.ICO',,
      CreateCollision )

  rc = CreateObject( 'WPUrlFolder',,
      'Internet^Sites',,
      folder_id,,
      'NOPRINT=YES;'||,
          'DEFAULTVIEW=ICON;'||,
          'HELPPANEL=33817;'||,
          'HELPLIBRARY=WPINET.HLP;'||,
          'SELFCLOSE=1;'||,
          'ICONVIEW=NONGRID,NORMAL;'||,
          'DETAILSVIEW=MINI;'||,
          'TREEVIEW=LINES,MINI;'||,
          'SORTCLASS=WPUrl;'||,
          'ALWAYSSORT=YES;'||,
        'OBJECTID=<Pilot_Link_Internet_Sites>',,
      CreateCollision )

    rc = CreateObject( 'WPUrl',,
        'PalmGear H.Q.^(Software and News)',,
        '<Pilot_Link_Internet_Sites>',,
        'NOTDEFAULTICON=YES;'||,
            'DEFAULTVIEW=CONTENTS;'||,
            'URL=http://www.palmgear.com/',,
        CreateCollision )


    rc = CreateObject( 'WPUrl',,
        'think. sync. pilot-link!',,
        '<Pilot_Link_Internet_Sites>',,
        'NOTDEFAULTICON=YES;'||,
            'DEFAULTVIEW=CONTENTS;'||,
            'URL=http://www.pilot-link.org/',,
        CreateCollision )

    rc = CreateObject( 'WPUrl',,
        'Palm Computing',,
        '<Pilot_Link_Internet_Sites>',,
        'NOTDEFAULTICON=YES;'||,
            'DEFAULTVIEW=CONTENTS;'||,
            'URL=http://www.palm.com/',,
        CreateCollision )

/*
  rc = CreateObject( 'WPProgram',,
      'PalmPilot Pro -> OS/2^Using OS/2 PPP',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME=NETSCAPE.EXE;'||,
          'STARTUPDIR='||current_dir||';'||,
          'PARAMETERS=file:///'||current_dir||'/os2ppp.htm',,
      CreateCollision )
*/

  /* Set defaults if needed */
  if PPPIP = '' then
    PPPIP = '10.1.0.1'
  if PilotIP = '' then
    PilotIP = '10.1.0.2'
  /* Need to make sure comport is in lower case for PPP command line. */
/*
  COMport = translate(COMport,"com","COM")
  rc = CreateObject( 'WPProgram',,
      'Pilot PPP Server',,
      folder_id,,
      'NOPRINT=YES;'||,
          'MINWIN=VIEWER;'||,
          'DEFAULTVIEW=RUNNING;'||,
          'EXENAME=PPP.EXE;'||,
          'STARTUPDIR='||bin_dir||';'||,
          'PARAMETERS='||COMport||' 19200 rtscts passive '||PPPIP||':'||PilotIP||' defaultroute silent;'||,
          'PROGTYPE=WINDOWABLEVIO',,
      CreateCollision )
*/

return

