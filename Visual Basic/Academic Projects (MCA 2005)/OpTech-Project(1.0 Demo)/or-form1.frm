VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form or_form1 
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "OpTech"
   ClientHeight    =   8340
   ClientLeft      =   1410
   ClientTop       =   840
   ClientWidth     =   9975
   FillColor       =   &H00E0E0E0&
   BeginProperty Font 
      Name            =   "Bookman Old Style"
      Size            =   9
      Charset         =   0
      Weight          =   300
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000000&
   Icon            =   "or-form1.frx":0000
   LinkTopic       =   "Form1"
   Picture         =   "or-form1.frx":0442
   ScaleHeight     =   8340
   ScaleWidth      =   9975
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer1 
      Interval        =   50
      Left            =   3255
      Top             =   5520
   End
   Begin ComctlLib.ProgressBar pbar 
      Height          =   195
      Left            =   120
      TabIndex        =   9
      Top             =   7800
      Width           =   5685
      _ExtentX        =   10028
      _ExtentY        =   344
      _Version        =   327682
      Appearance      =   0
   End
   Begin VB.PictureBox pic1 
      Height          =   975
      Left            =   8640
      Picture         =   "or-form1.frx":130C
      ScaleHeight     =   915
      ScaleWidth      =   795
      TabIndex        =   8
      Top             =   360
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.PictureBox pic 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H80000004&
      Height          =   975
      Left            =   8760
      ScaleHeight     =   915
      ScaleWidth      =   795
      TabIndex        =   7
      Top             =   3720
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.ComboBox tcomb 
      BackColor       =   &H80000004&
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   375
      Left            =   1080
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   4680
      Visible         =   0   'False
      Width           =   390
   End
   Begin MSComctlLib.StatusBar orstat 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   5
      ToolTipText     =   "Shows current selected option"
      Top             =   8085
      Width           =   9975
      _ExtentX        =   17595
      _ExtentY        =   450
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   2
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin RichTextLib.RichTextBox rtf 
      Height          =   1695
      Left            =   0
      TabIndex        =   4
      ToolTipText     =   "Shows the selected problem."
      Top             =   1680
      Width           =   9855
      _ExtentX        =   17383
      _ExtentY        =   2990
      _Version        =   393217
      BackColor       =   16777215
      ReadOnly        =   -1  'True
      ScrollBars      =   3
      TextRTF         =   $"or-form1.frx":350AE
   End
   Begin VB.Frame fpid 
      BackColor       =   &H80000004&
      Caption         =   "Select Problem ID"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000006&
      Height          =   735
      Left            =   540
      TabIndex        =   0
      ToolTipText     =   "Containts Problem-IDs, Select one."
      Top             =   225
      Width           =   4290
      Begin VB.CommandButton ccancel 
         BackColor       =   &H80000004&
         Caption         =   "&Cancel"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   3360
         MaskColor       =   &H00808080&
         Style           =   1  'Graphical
         TabIndex        =   3
         ToolTipText     =   "Cancel current option"
         Top             =   255
         Width           =   855
      End
      Begin VB.CommandButton pidok 
         BackColor       =   &H80000004&
         Caption         =   "&Ok"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2580
         MaskColor       =   &H00808080&
         Style           =   1  'Graphical
         TabIndex        =   2
         ToolTipText     =   "I selected the Problem Id. Go!!!"
         Top             =   255
         Width           =   780
      End
      Begin VB.ComboBox combopid 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000006&
         Height          =   315
         Left            =   630
         Style           =   2  'Dropdown List
         TabIndex        =   1
         ToolTipText     =   "Contains Problem-IDs, Select one."
         Top             =   255
         Width           =   1845
      End
      Begin VB.Label copt 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   195
         Left            =   180
         TabIndex        =   16
         ToolTipText     =   "Shows current selected option"
         Top             =   330
         Width           =   210
      End
   End
   Begin MSComDlg.CommonDialog dialog1 
      Left            =   4320
      Top             =   5760
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      BorderStyle     =   6  'Inside Solid
      Index           =   1
      X1              =   15
      X2              =   5579
      Y1              =   0
      Y2              =   0
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   0
      X1              =   -30
      X2              =   5700
      Y1              =   15
      Y2              =   15
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "O"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   15.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Index           =   0
      Left            =   4965
      TabIndex        =   15
      Top             =   480
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      BackStyle       =   0  'Transparent
      Caption         =   "p"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   15.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Index           =   1
      Left            =   5325
      TabIndex        =   14
      Top             =   480
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      BackStyle       =   0  'Transparent
      Caption         =   "T"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   15.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Index           =   2
      Left            =   5685
      TabIndex        =   13
      Top             =   480
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      BackStyle       =   0  'Transparent
      Caption         =   "e"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   15.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Index           =   3
      Left            =   6045
      TabIndex        =   12
      Top             =   480
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      BackStyle       =   0  'Transparent
      Caption         =   "c"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   15.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Index           =   4
      Left            =   6405
      TabIndex        =   11
      Top             =   480
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      BackStyle       =   0  'Transparent
      Caption         =   "h"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   15.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Index           =   5
      Left            =   6765
      TabIndex        =   10
      Top             =   480
      Width           =   375
   End
   Begin VB.Menu mfile 
      Caption         =   "&File "
      Begin VB.Menu mnew 
         Caption         =   "New"
         Begin VB.Menu nlpp 
            Caption         =   " Linear Programming Problem"
            Shortcut        =   ^A
         End
         Begin VB.Menu sep 
            Caption         =   "-"
         End
         Begin VB.Menu newtp 
            Caption         =   "Transportation Problem"
            Shortcut        =   ^B
         End
         Begin VB.Menu sep2 
            Caption         =   "-"
         End
         Begin VB.Menu newap 
            Caption         =   "Assignment Problem"
            Shortcut        =   ^C
         End
         Begin VB.Menu sep6 
            Caption         =   "-"
         End
         Begin VB.Menu newsp 
            Caption         =   "Sequential Problem"
            Begin VB.Menu m2 
               Caption         =   "2 Machines-K jobs"
               Shortcut        =   ^D
            End
            Begin VB.Menu sep10 
               Caption         =   "-"
            End
            Begin VB.Menu m3 
               Caption         =   "3 Machines-K jobs"
               Shortcut        =   ^E
            End
            Begin VB.Menu sep11 
               Caption         =   "-"
            End
            Begin VB.Menu j2 
               Caption         =   "K Machines-2 jobs"
               Shortcut        =   ^F
            End
            Begin VB.Menu sp20 
               Caption         =   "-"
            End
            Begin VB.Menu kmacnjob 
               Caption         =   "K Machine-N jobs"
               Shortcut        =   ^G
            End
         End
         Begin VB.Menu sep9 
            Caption         =   "-"
         End
         Begin VB.Menu nmatx 
            Caption         =   "Matrix"
            Shortcut        =   ^H
         End
         Begin VB.Menu sepmatx1 
            Caption         =   "-"
         End
         Begin VB.Menu nleqns 
            Caption         =   "Linear System of Equations"
            Shortcut        =   ^I
         End
      End
      Begin VB.Menu sepe 
         Caption         =   "-"
      End
      Begin VB.Menu xit 
         Caption         =   "Exit"
         Shortcut        =   +{F12}
      End
   End
   Begin VB.Menu dbop 
      Caption         =   "&Edit "
      Begin VB.Menu update 
         Caption         =   "Update"
         Begin VB.Menu editlpp 
            Caption         =   "Linear Programming Problem"
            Shortcut        =   ^J
         End
         Begin VB.Menu sep40 
            Caption         =   "-"
         End
         Begin VB.Menu edittp 
            Caption         =   "Transportation Problem"
            Shortcut        =   ^K
         End
         Begin VB.Menu sep41 
            Caption         =   "-"
         End
         Begin VB.Menu editap 
            Caption         =   "Assignment Problem"
            Shortcut        =   ^L
         End
         Begin VB.Menu sep42 
            Caption         =   "-"
         End
         Begin VB.Menu editsp 
            Caption         =   "Sequential Problem"
            Begin VB.Menu em2 
               Caption         =   "2 Machines-K jobs"
               Shortcut        =   ^M
            End
            Begin VB.Menu sep12 
               Caption         =   "-"
            End
            Begin VB.Menu em3 
               Caption         =   "3 Machines-K jobs"
               Shortcut        =   ^N
            End
            Begin VB.Menu sep13 
               Caption         =   "-"
            End
            Begin VB.Menu ej2 
               Caption         =   "K Machines-2 jobs"
               Shortcut        =   ^O
            End
            Begin VB.Menu sep23 
               Caption         =   "-"
            End
            Begin VB.Menu ekmacnjob 
               Caption         =   "K Machines-N jobs"
               Shortcut        =   ^P
            End
         End
         Begin VB.Menu sep43 
            Caption         =   "-"
         End
         Begin VB.Menu ematx 
            Caption         =   "Matrix"
            Shortcut        =   ^Q
         End
         Begin VB.Menu sep35 
            Caption         =   "-"
         End
         Begin VB.Menu eleqns 
            Caption         =   "Linear System of Equations "
            Shortcut        =   ^R
         End
      End
      Begin VB.Menu sepnew1 
         Caption         =   "-"
      End
      Begin VB.Menu mdel 
         Caption         =   "Delete "
         Begin VB.Menu dlpp 
            Caption         =   "Linear Programming Problem"
            Shortcut        =   +{F2}
         End
         Begin VB.Menu sep51 
            Caption         =   "-"
         End
         Begin VB.Menu dtpp 
            Caption         =   "Transportation Problem"
            Shortcut        =   +{F3}
         End
         Begin VB.Menu sep52 
            Caption         =   "-"
         End
         Begin VB.Menu dap 
            Caption         =   "Assignment Problem"
            Shortcut        =   +{F4}
         End
         Begin VB.Menu sep45 
            Caption         =   "-"
         End
         Begin VB.Menu dsp 
            Caption         =   "Sequential Problem"
            Begin VB.Menu d2mkj 
               Caption         =   "2-Machines K-Jobs"
               Shortcut        =   +{F5}
            End
            Begin VB.Menu sep53 
               Caption         =   "-"
            End
            Begin VB.Menu d3mkj 
               Caption         =   "3-Machines K-Jobs"
               Shortcut        =   +{F6}
            End
            Begin VB.Menu sep54 
               Caption         =   "-"
            End
            Begin VB.Menu dkm2j 
               Caption         =   "K-Machines 2-Jobs"
               Shortcut        =   +{F7}
            End
            Begin VB.Menu sep55 
               Caption         =   "-"
            End
            Begin VB.Menu dkmnj 
               Caption         =   "K-Machines N-Jobs"
               Shortcut        =   +{F8}
            End
         End
         Begin VB.Menu sep56 
            Caption         =   "-"
         End
         Begin VB.Menu dm 
            Caption         =   "Matrix"
            Shortcut        =   +{F9}
         End
         Begin VB.Menu sep50 
            Caption         =   "-"
         End
         Begin VB.Menu dlsoe 
            Caption         =   "Linear System of Equations"
            Shortcut        =   +{F11}
         End
      End
      Begin VB.Menu sepxy 
         Caption         =   "-"
      End
      Begin VB.Menu reda 
         Caption         =   "Reassign Database"
      End
   End
   Begin VB.Menu solve 
      Caption         =   "&Solve "
      Begin VB.Menu lpp 
         Caption         =   "Linear Programming Problem"
         Begin VB.Menu simplex 
            Caption         =   "Simplex (Big-M included)"
            Shortcut        =   ^S
         End
         Begin VB.Menu sep3 
            Caption         =   "-"
         End
         Begin VB.Menu dual_simplex 
            Caption         =   "Dual Simplex"
            Shortcut        =   ^T
         End
         Begin VB.Menu sep4 
            Caption         =   "-"
         End
         Begin VB.Menu integerprgmming 
            Caption         =   "Integer Programming(Gomery)"
            Shortcut        =   ^U
         End
         Begin VB.Menu sepr 
            Caption         =   "-"
         End
         Begin VB.Menu mintprogramming 
            Caption         =   "Mixed Integer Programming(Fractional Cut)"
            Shortcut        =   ^V
         End
         Begin VB.Menu x 
            Caption         =   "-"
         End
         Begin VB.Menu bbmethod 
            Caption         =   "Branch And Bound Method"
            Shortcut        =   ^W
         End
         Begin VB.Menu sep34 
            Caption         =   "-"
         End
         Begin VB.Menu dualofprimal 
            Caption         =   "Dual Of Primal"
            Shortcut        =   ^Y
         End
         Begin VB.Menu sep30 
            Caption         =   "-"
         End
         Begin VB.Menu lppgraph 
            Caption         =   "Graphical Solution"
            Shortcut        =   ^Z
         End
      End
      Begin VB.Menu sep44 
         Caption         =   "-"
      End
      Begin VB.Menu tp 
         Caption         =   "Transportation Problems"
         Begin VB.Menu vam 
            Caption         =   "VAM Method(Modi included)"
            Shortcut        =   {F2}
         End
         Begin VB.Menu sep8 
            Caption         =   "-"
         End
         Begin VB.Menu nwcr 
            Caption         =   "NWCR Method(Modi included)"
            Shortcut        =   {F3}
         End
         Begin VB.Menu sep7 
            Caption         =   "-"
         End
         Begin VB.Menu matminmethod 
            Caption         =   "Least Cost Method(Modi included)"
            Shortcut        =   {F4}
         End
      End
      Begin VB.Menu sep46 
         Caption         =   "-"
      End
      Begin VB.Menu ap 
         Caption         =   "Assignment Problems"
         Begin VB.Menu hungary 
            Caption         =   "Hungarian Method"
            Shortcut        =   {F5}
         End
      End
      Begin VB.Menu sep47 
         Caption         =   "-"
      End
      Begin VB.Menu spsolve 
         Caption         =   "Sequential Problems"
         Begin VB.Menu sm2 
            Caption         =   "2 Machines-K jobs"
            Shortcut        =   {F6}
         End
         Begin VB.Menu sep22 
            Caption         =   "-"
         End
         Begin VB.Menu sm3 
            Caption         =   "3 Machines-K jobs"
            Shortcut        =   {F7}
         End
         Begin VB.Menu sep14 
            Caption         =   "-"
         End
         Begin VB.Menu sj2 
            Caption         =   "K Machines-2 jobs"
            Shortcut        =   {F8}
         End
         Begin VB.Menu sep21 
            Caption         =   "-"
         End
         Begin VB.Menu skmacnjob 
            Caption         =   "K Machines-N jobs"
            Shortcut        =   {F9}
         End
      End
      Begin VB.Menu sep48 
         Caption         =   "-"
      End
      Begin VB.Menu smatx 
         Caption         =   "Matrix"
         Begin VB.Menu dai 
            Caption         =   "Matrix Properties"
            Shortcut        =   {F11}
         End
         Begin VB.Menu sep31 
            Caption         =   "-"
         End
         Begin VB.Menu rom 
            Caption         =   "Rank Of Matrix"
            Shortcut        =   {F12}
         End
         Begin VB.Menu sep33 
            Caption         =   "-"
         End
         Begin VB.Menu rcfom 
            Caption         =   "Row Canonical Form Of Matrix"
            Shortcut        =   ^{F1}
         End
      End
      Begin VB.Menu sep49 
         Caption         =   "-"
      End
      Begin VB.Menu alsoe 
         Caption         =   "Linear System Of Equations"
         Begin VB.Menu cr 
            Caption         =   "Cramer's Rule"
            Shortcut        =   ^{F2}
         End
         Begin VB.Menu sep38 
            Caption         =   "-"
         End
         Begin VB.Menu xinvabrule 
            Caption         =   "(X=Inverse(A)xB) Rule"
            Shortcut        =   ^{F3}
         End
      End
   End
   Begin VB.Menu sall 
      Caption         =   "&View "
      Begin VB.Menu alllpp 
         Caption         =   "Linear Programming Problems"
         Shortcut        =   ^{F4}
      End
      Begin VB.Menu sep15 
         Caption         =   "-"
      End
      Begin VB.Menu alltpp 
         Caption         =   "Transportation Problems"
         Shortcut        =   ^{F5}
      End
      Begin VB.Menu sep16 
         Caption         =   "-"
      End
      Begin VB.Menu allapp 
         Caption         =   "Assignment Problems"
         Shortcut        =   ^{F6}
      End
      Begin VB.Menu sep17 
         Caption         =   "-"
      End
      Begin VB.Menu allsp 
         Caption         =   "Sequential Problems"
         Begin VB.Menu allm2 
            Caption         =   "2 Machine-K jobs"
            Shortcut        =   ^{F7}
         End
         Begin VB.Menu SEP18 
            Caption         =   "-"
         End
         Begin VB.Menu allm3 
            Caption         =   "3 Machine-K jobs"
            Shortcut        =   ^{F8}
         End
         Begin VB.Menu SEP19 
            Caption         =   "-"
         End
         Begin VB.Menu allj2 
            Caption         =   "K Machines-2 jobs"
            Shortcut        =   ^{F9}
         End
         Begin VB.Menu sep28 
            Caption         =   "-"
         End
         Begin VB.Menu allkmacnjobs 
            Caption         =   "K Machines- N jobs"
            Shortcut        =   ^{F11}
         End
      End
      Begin VB.Menu sep29 
         Caption         =   "-"
      End
      Begin VB.Menu allmats 
         Caption         =   "Matrices"
         Shortcut        =   ^{F12}
      End
      Begin VB.Menu sep32 
         Caption         =   "-"
      End
      Begin VB.Menu lsoe 
         Caption         =   "Linear System Of Equations"
         Shortcut        =   +{F1}
      End
   End
   Begin VB.Menu mtools 
      Caption         =   "&Tools"
      Begin VB.Menu cretora 
         Caption         =   "Real to Rational Converter"
         Shortcut        =   +^{F1}
      End
      Begin VB.Menu tsep 
         Caption         =   "-"
      End
      Begin VB.Menu tdc 
         Caption         =   "Date Calculator And  Time"
         Shortcut        =   +^{F2}
      End
   End
   Begin VB.Menu mehlp 
      Caption         =   "&Help "
      Begin VB.Menu mehlpfile 
         Caption         =   "OpTech Help Topics"
         Shortcut        =   {F1}
      End
      Begin VB.Menu seph 
         Caption         =   "-"
      End
      Begin VB.Menu about 
         Caption         =   "About OpTech"
         Shortcut        =   +^{F3}
      End
   End
   Begin VB.Menu opts 
      Caption         =   "Options "
      Begin VB.Menu savtofile 
         Caption         =   "Save To File"
      End
      Begin VB.Menu sepo1 
         Caption         =   "-"
      End
      Begin VB.Menu cpy 
         Caption         =   "Copy"
      End
      Begin VB.Menu sepo2 
         Caption         =   "-"
      End
      Begin VB.Menu print 
         Caption         =   "Print"
      End
   End
End
Attribute VB_Name = "or_form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Declare Function WinHelp Lib "user32" Alias "WinHelpA" (ByVal hwnd As Long _
 , ByVal lpHelpFile As String, ByVal wCommand As Long, ByVal dwData As Long) As Long

Dim chois As String
Dim toright(6) As Boolean
Dim initials(6) As String
Dim very_start As Boolean


Private Sub formattextinrtf(rtf As RichTextBox, strg As String, fnt As String, sze As Integer)

With rtf
 .SelStart = 0
 .SelStart = .Find(strg)
 .Span (strg)
 .SelColor = RGB(50, 50, 170)
 .SelFontName = "Courier New"
 .SelFontSize = 9
 .SelBold = True
End With
End Sub

Private Sub about_Click()
    fabout.Show vbModal, Me
End Sub

Private Sub allapp_Click()
On Error GoTo xit
  
    r.hold = 3
    r.flg = 2
    r.Show vbModal, Me
    'me.hide

Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub allj2_Click()
On Error GoTo xit

    r.hold = 3
    r.flg = 5
    r.Show vbModal, Me
    'me.hide

Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub allkmacnjobs_Click()
On Error GoTo xit

    r.hold = 3
    r.flg = 6
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub alllpp_Click()
On Error GoTo xit
    
    r.hold = 3
    r.flg = 0
    r.Show vbModal, Me
    'Me.Hide

Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub allm2_Click()
On Error GoTo xit

    r.hold = 3
    r.flg = 3
    r.Show vbModal, Me
    'Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub allm3_Click()
On Error GoTo xit
 
    r.hold = 3
    r.flg = 4
    r.Show vbModal, Me
    'Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub allmats_Click()
On Error GoTo xit

    r.hold = 3
    r.flg = 7
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub alltpp_Click()
On Error GoTo xit

    r.hold = 3
    r.flg = 1
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub bbmethod_Click()
On Error GoTo xit
    copt = "Branch And Bound method"
Call lpp_load(False, combopid)
chois = "BBM"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub ccancel_Click()
    Call enable_cntrls(False)
End Sub

Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub combopid_KeyPress(pKey As Integer)
    If pKey = 13 And combopid.ListIndex <> -1 Then
        Call pidok_Click
    End If
End Sub

Public Sub combopid_Click()
On Error GoTo xit
    If combopid.ListIndex <> -1 Then
        Call processtxtbox(combopid.List(combopid.ListIndex), chois)
        pidok.Enabled = True
    End If
    Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub processtxtbox(pid As Long, chois As String)
On Error GoTo xit
Dim t1 As String
Dim lpp As New lpp_solve
Dim Y As New Recordset
Dim y1 As New Recordset
Dim y2 As New Recordset
Dim oldn As Integer
Dim oldm As Integer
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim l As Integer
Dim flg As Integer
Dim mx As matrix
With rtf
    Call connect
     
    If chois = "DMATX" Or chois = "EMATX" Or chois = "MATX1" Or chois = "MATX21" Or chois = "MATX211" Then
        rtf.Text = ""
        Call create_matrix(pid, mx)
        Call display_matrix(rtf, mx, 5, True, False, pbar)
    End If
     
     If chois = "DLINEAR" Or chois = "ELINEAR" Or chois = "CRAMER" Or chois = "XINVAB" Then
        rtf.Text = ""
        Call create_matrix(pid, mx)
        Call display_linear_eqns(rtf, mx, 5, True, False, pbar)
    End If
    
     If chois = "DLPP" Or chois = "ELPP" Or chois = "SOLVE_SIMPLEX" Or chois = "SOLVE_DSIMPLEX" Or chois = "SOLVE_GOMERY" Or chois = "SOLVE_MIXED" Or chois = "BBM" Or chois = "DUAL" Or chois = "LPPG" Then
        i = 0
        oldn = 0
        Set Y = dn.cn.Execute("select pid,n,m from lpp_main where pid=" & pid & " order by n,m")
        t1 = "LINEAR PROGRAMMING PROBLEM DEFINITION"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        If Y.RecordCount > 0 Then Y.MoveFirst
        pbar.Visible = True
        pbar.Value = 0
        pbar.max = CLng(Y.RecordCount)
        While Not Y.EOF
            If oldn < Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                i = i + 1
                j = 0
                t1 = "LPP WITH VARIABLE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            
            If oldm < Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = "CONSTRAINT DEGREE " & Trim(str(oldm)) + ", PROBLEM ID:" & Trim(str(Y.Fields("pid")))
                .Text = .Text & vbCrLf & vbCrLf & Space(15) & t1 & vbCrLf
                .Text = .Text & Space(15) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
                k = 0
            End If
                k = k + 1
                lpp.pid = Y.Fields("pid")
                lpp.type_solve = "BBM"
                lpp.Visible = False
                .Text = .Text & lpp.get_problem(pbar)
            Y.MoveNext
        Wend
        If i = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
        End If
    End If
    
    
     If chois = "DTPP" Or chois = "ETPP" Or chois = "VAM" Or chois = "NWCR" Or chois = "MMM" Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select tid,nsrc as n,ndst as m from tpp_main where(tid=" & pid & " and  tora='T') order by nsrc,ndst")
        If Y.RecordCount > 0 Then Y.MoveFirst
        pbar.Visible = True
        pbar.Value = 0
        If Val(Y.RecordCount) > 0 Then
            pbar.max = Val(Y.Fields("n")) * Val(Y.Fields("m"))
        Else
            pbar.max = 1
        End If
        t1 = "TRANSPORTATION PROBLEM DEFINITION"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         t1 = "ROWS:SOURCES & COLUMNS:DESTINATIONS(MATRIX ELEMENTS COST/TIME)"
         .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                l = l + 1
                j = 0
                t1 = "TP WITH SOURCE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            
            If oldm <> Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = "DESTINATION DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & Space(15) & t1 & vbCrLf
                .Text = .Text & Space(15) & give_sepchar("-", Len(t1)) & vbCrLf
                k = 0
            End If
                
                k = k + 1
                Set y1 = dn.cn.Execute("select t_type from tpp_main where tid=" & Y.Fields("tid"))
                .Text = .Text & vbCrLf & vbCrLf & Space(5) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("tid"))) & vbCrLf
                .Text = .Text & Space(5) & "PROBLEM TYPE:" & IIf(y1.Fields("t_type") = "MI", "MINIMIZATION", "MAXIMIZATION") & vbCrLf & vbCrLf
                t1 = "  SRC/DST:"
                For i = 1 To oldm Step 1
                    t1 = t1 & spaces(10, "D" + Trim(str(i))) & Mid("D" + Trim(str(i)), 1, 10)
                Next i
                t1 = t1 & "      CAPS"
                .Text = .Text & Space(5) & t1 & vbCrLf
                For i = 1 To oldn Step 1
                    t1 = spaces(10, "S" + Trim(str(i))) & Mid("S" + Trim(str(i)), 1, 10)
                    Set y1 = dn.cn.Execute("select cost from tpp_sub2 where(tid=" & Y.Fields("tid") & " and srcid=" & i & ") order by dstid")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(10, Trim(str(y1.Fields("cost")))) & Mid(Trim(str(y1.Fields("cost"))), 1, 10)
                        pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
                        y1.MoveNext
                    Wend
                    Set y1 = dn.cn.Execute("select recap from tpp_sub1 where(tid=" & Y.Fields("tid") & " and sord='S' and sdno=" & i & ")")
                    y1.MoveFirst
                    t1 = t1 & spaces(10, Trim(str(y1.Fields("recap")))) & Mid(Trim(y1.Fields("recap")), 1, 10)
                    .Text = .Text & Space(5) & t1 & vbCrLf
                Next i
                t1 = "      REQS"
                Set y1 = dn.cn.Execute("select recap from tpp_sub1 where(tid=" & Y.Fields("tid") & " and sord='D') order by sdno")
                y1.MoveFirst
                While Not y1.EOF
                    t1 = t1 & spaces(10, Trim(str(y1.Fields("recap")))) & Mid(Trim(str(y1.Fields("recap"))), 1, 10)
                    y1.MoveNext
                Wend
                .Text = .Text & Space(5) & t1 & vbCrLf & vbCrLf
            
        Y.MoveNext
       Wend
       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
       pbar.Value = pbar.max
       pbar.Visible = False
    End If
    
    If chois = "DAP" Or chois = "EAP" Or chois = "AP" Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select tid,nsrc as n,ndst as m from tpp_main where(tid=" & pid & " and tora='A') order by nsrc")
        If Y.RecordCount > 0 Then Y.MoveFirst
        pbar.Visible = True
        pbar.Value = 0
        If Val(Y.RecordCount) > 0 Then
            pbar.max = Val(Y.Fields("n")) * Val(Y.Fields("m"))
        Else
            pbar.max = 1
        End If
        t1 = "ASSIGNMENT PROBLEM DEFINITION"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         t1 = "ROWS:MACHINES & COLUMNS:JOBS(MATRIX ELEMENTS COST/TIME)"
         .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                l = l + 1
                k = 0
                t1 = "AP WITH MACHINE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
                
                k = k + 1
                Set y1 = dn.cn.Execute("select t_type from tpp_main where tid=" & Y.Fields("tid"))
                .Text = .Text & vbCrLf & vbCrLf & Space(5) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("tid"))) & vbCrLf
                .Text = .Text & Space(5) & "PROBLEM TYPE:" & IIf(y1.Fields("t_type") = "MI", "MINIMIZATION", "MAXIMIZATION") & vbCrLf & vbCrLf
                t1 = "  MAC/JOB:"
                For i = 1 To oldn Step 1
                    t1 = t1 & spaces(10, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 10)
                Next i
                .Text = .Text & Space(5) & t1 & vbCrLf
                For i = 1 To oldn Step 1
                    t1 = spaces(10, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 10)
                    Set y1 = dn.cn.Execute("select cost from tpp_sub2 where(tid=" & Y.Fields("tid") & " and srcid=" & i & ") order by dstid")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(10, Trim(str(y1.Fields("cost")))) & Mid(Trim(str(y1.Fields("cost"))), 1, 10)
                        pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
                        y1.MoveNext
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
                Next i
                .Text = .Text & vbCrLf & vbCrLf & Space(10) & "EACH MACHINE CAN GIVE SERVICE TO A SINGLE JOB."
                .Text = .Text & vbCrLf & Space(10) & "EACH JOB REQUIRES SERVICE OF ONE & ONLY ONE MACHINE." & vbCrLf & vbCrLf
          Y.MoveNext
       Wend
       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
       pbar.Value = pbar.max
       pbar.Visible = False
    End If
    
    flg = IIf(chois = "DM2" Or chois = "M2" Or chois = "SM2", 3, IIf(chois = "SM3" Or chois = "M3" Or chois = "DM3", 4, -1))
    
    If flg = 3 Or flg = 4 Then
        Call connect
        t1 = "SEQUENTIAL PROBLEM DEFINITION" & IIf(flg = 3, "(2-MACHINES & K-JOBS)", "(3-MACHINES & K-JOBS)")
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        t1 = "ROWS:JOBS & COLUMNS:MACHINES(MATRIX ELEMENTS TIME)"
        .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
        i = 0
        oldm = 0
        Set Y = dn.cn.Execute("select sid,js from sp_main where(sid=" & pid & "and s_type='" & IIf(flg = 3, "M2", "M3") & "')")
        If Y.RecordCount > 0 Then Y.MoveFirst
        pbar.Visible = True
        While Not Y.EOF
            If oldm <> Y.Fields("js") Then
                oldm = Y.Fields("js")
                i = i + 1
                k = 0
                t1 = "SP WITH JOB DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            k = k + 1
            .Text = .Text & vbCrLf & vbCrLf & Space(13) & "PROBLEM ID:" & Trim(str(Y.Fields("sid"))) & vbCrLf
            t1 = "        JOB/MAC:"
            For i = 1 To IIf(flg = 3, 2, 3) Step 1
                t1 = t1 & spaces(16, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 16)
            Next i
            .Text = .Text & Space(5) & t1 & vbCrLf
            pbar.max = oldm * IIf(flg = 3, 2, 3)
            pbar.Value = 0
            For i = 1 To oldm Step 1
                    t1 = spaces(16, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 16)
                    Set y1 = dn.cn.Execute("select time_dur from sp_sub1 where(sid=" & Y.Fields("sid") & " and job=" & i & ") order by mac")
                    y1.MoveFirst
                     While Not y1.EOF
                        t1 = t1 & spaces(16, Trim(str(y1.Fields("time_dur")))) & Mid(Trim(str(y1.Fields("time_dur"))), 1, 16)
                        y1.MoveNext
                        pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
            Next i
            Y.MoveNext
        Wend
        If i = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
       pbar.Value = pbar.max
       pbar.Visible = False
    End If
    
    If chois = "DJ2" Or chois = "J2" Or chois = "SJ2" Then
        Call connect
        t1 = "SEQUENTIAL PROBLEM DEFINITION(K-MACHINES & 2-JOBS)"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        t1 = "ROWS:MACHINES & COLUMNS:JOBS(MATRIX ELEMENTS TIME)"
        .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
        i = 0
        oldm = 0
        Set Y = dn.cn.Execute("select sid,ms from sp_main where(sid=" & pid & " and s_type='J2')")
        If Y.RecordCount > 0 Then Y.MoveFirst
        While Not Y.EOF
            If oldm <> Y.Fields("ms") Then
                oldm = Y.Fields("ms")
                i = i + 1
                k = 0
                t1 = "SP WITH MACHINE DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            k = k + 1
            .Text = .Text & vbCrLf & vbCrLf & Space(13) & "PROBLEM ID:" & Trim(str(Y.Fields("sid"))) & vbCrLf
            t1 = "        MAC/JOB:"
            For i = 1 To 2 Step 1
                t1 = t1 & spaces(16, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 16)
            Next i
           .Text = .Text & Space(5) & t1 & vbCrLf
           pbar.Visible = True
           pbar.Value = 0
           pbar.max = 3 * oldm
            For i = 1 To oldm Step 1
                    t1 = spaces(16, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 16)
                    Set y1 = dn.cn.Execute("select time_dur from sp_sub1 where(sid=" & Y.Fields("sid") & " and mac=" & i & ") order by job")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(16, Trim(str(y1.Fields("time_dur")))) & Mid(Trim(str(y1.Fields("time_dur"))), 1, 16)
                        y1.MoveNext
                        pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
            Next i
            .Text = .Text & vbCrLf & vbCrLf & Space(10) & "MACHINE ORDER FOR JOB-1     MACHINE ORDER FOR JOB-2" & vbCrLf
            Set y1 = dn.cn.Execute("select mac from sp_sub1 where(sid=" & Y.Fields("sid") & " and job=1) order by e_order")
            Set y2 = dn.cn.Execute("select mac from sp_sub1 where(sid=" & Y.Fields("sid") & " and job=2) order by e_order")
            y1.MoveFirst
            y2.MoveFirst
            While (Not y1.EOF And Not y2.EOF)
                t1 = "MACHINE " & Mid(Trim(y1.Fields("mac")), 1, 18)
                .Text = .Text & vbCrLf & Space(15) & t1 & spaces(18, t1)
                .Text = .Text & Space(10) & "MACHINE " & Mid(Trim(y2.Fields("mac")), 1, 18) & vbCrLf
                pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
                y1.MoveNext
                y2.MoveNext
            Wend
            Y.MoveNext
        Wend
        If i = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
        End If
        pbar.Value = pbar.max
        pbar.Visible = False
    End If
    
    
    If chois = "DMK" Or chois = "MK" Or chois = "SMK" Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select sid as tid,ms as n,js as m from sp_main where(sid=" & pid & " and s_type='MK') order by ms,js")
        If Y.RecordCount > 0 Then Y.MoveFirst
        pbar.Visible = True
        t1 = "SEQUENTIAL PROBLEM DEFINITION(K MACHINES-N JOBS):"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         t1 = "ROWS:MACHINES & COLUMNS:JOBS"
         .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                l = l + 1
                j = 0
                t1 = "SP WITH MACHINE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            
            If oldm <> Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = "JOB DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & Space(15) & t1 & vbCrLf
                .Text = .Text & Space(15) & give_sepchar("-", Len(t1)) & vbCrLf
                k = 0
            End If
                
                k = k + 1
                .Text = .Text & vbCrLf & vbCrLf & Space(5) & "PROBLEM ID:" & Trim(str(Y.Fields("tid"))) & vbCrLf & vbCrLf
                t1 = "  MAC/JOB:"
                For i = 1 To oldm Step 1
                    t1 = t1 & spaces(10, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 10)
                Next i
                .Text = .Text & Space(5) & t1 & vbCrLf
                pbar.max = oldm * oldn
                pbar.Value = 0
                For i = 1 To oldn Step 1
                    t1 = spaces(10, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 10)
                    Set y1 = dn.cn.Execute("select time_dur as cost from sp_sub1 where(sid=" & Y.Fields("tid") & " and mac=" & i & ") order by job")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(10, Trim(str(y1.Fields("cost")))) & Mid(Trim(str(y1.Fields("cost"))), 1, 10)
                        pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
                        y1.MoveNext
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
                Next i
                .Text = .Text & vbCrLf & vbCrLf
            
        Y.MoveNext
       Wend
       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
       pbar.Value = pbar.max
       pbar.Visible = False
    End If
    rtf.Visible = True
    pic.Visible = False
End With

Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub Command1_Click()
    Call enable_cntrls(False)
End Sub


Private Sub copt_Change()
    very_start = True
    orstat.Panels(1).Text = IIf(copt.Caption <> "", copt, "Please select an option!")
    orstat.Visible = True
    fpid.Width = copt.Width + combopid.Width + pidok.Width + ccancel.Width + 450
    combopid.left = copt.left + copt.Width + 50
    pidok.left = combopid.left + combopid.Width + 50
    ccancel.left = pidok.left + pidok.Width + 5
    Call Form_Resize
End Sub

Private Sub cr_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Apply CRAMER'S Rule"
Call matx_load(False, combopid)
chois = "CRAMER"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub cretora_Click()
On Error GoTo xit
    ftools.HelpContextID = 20
    ftools.opts.Visible = True
    ftools.cexit.Visible = False
    ftools.Caption = "Real to Rational converter"
    ftools.datecalculatordemo21.Visible = False
    ftools.Label3.Visible = False
    ftools.Height = 2200
    ftools.Width = 7050
    ftools.Show vbModal, Me
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub d2mkj_Click()
On Error GoTo xit
enable_menu_properly (6)
If d2mkj.Enabled = False Then
    Exit Sub
End If
enable_cntrls (False)
copt = "Delete Sequential Problem(2-Mac K-Job)"
Call sp_load(0, combopid)
chois = "DM2"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub d3mkj_Click()
On Error GoTo xit
enable_menu_properly (7)
If d3mkj.Enabled = False Then
    Exit Sub
End If
enable_cntrls (False)
copt = "Delete Sequential Problem(3-Mac K-Job)"
Call sp_load(1, combopid)
chois = "DM3"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub dai_Click()
On Error GoTo xit
Call enable_cntrls(False)
Call matx_load(True, combopid)
chois = "MATX1"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub dap_Click()
On Error GoTo xit
enable_menu_properly (3)
If dap.Enabled = False Then
    Exit Sub
End If
Call enable_cntrls(False)
copt = "Delete Assignment Problem"
Call tpp_load(False, combopid)
chois = "DAP"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub
Private Sub dkm2j_Click()
On Error GoTo xit
enable_menu_properly (8)
If dkm2j.Enabled = False Then
    Exit Sub
End If
enable_cntrls (False)
copt = "Delete Sequential Problem(K-Mac 2-Job)"
Call sp_load(2, combopid)
chois = "DJ2"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub dkmnj_Click()
On Error GoTo xit
enable_menu_properly (9)
If dkmnj.Enabled = False Then
    Exit Sub
End If
enable_cntrls (False)
copt = "Delete Sequential Problem(K-Mac N-Job)"
Call sp_load(3, combopid)
chois = "DMK"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub dlpp_Click()
On Error GoTo xit
enable_menu_properly (1)
If dlpp.Enabled = False Then
    Exit Sub
End If
Call enable_cntrls(False)
copt = "Delete Linear Programming Problem"
Call lpp_load(False, combopid)
chois = "DLPP"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub dlsoe_Click()
On Error GoTo xit
enable_menu_properly (5)
If dlsoe.Enabled = False Then
    Exit Sub
End If
Call enable_cntrls(False)
copt = "Delete Linear System Of Equations"
Call matx_load(False, combopid)
chois = "DLINEAR"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub dm_Click()
On Error GoTo xit
enable_menu_properly (4)
If dm.Enabled = False Then
    Exit Sub
End If
Call enable_cntrls(False)
copt = "Delete Matrix"
Call matx_load(True, combopid)
chois = "DMATX"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub dtpp_Click()
On Error GoTo xit
enable_menu_properly (2)
If dtpp.Enabled = False Then
    Exit Sub
End If
Call enable_cntrls(False)
copt = "Delete Transportation Problem"
Call tpp_load(True, combopid)
chois = "DTPP"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub dual_simplex_Click()
On Error GoTo xit
    copt = "Dual Simplex Method"
    Call lpp_load(False, combopid)
    chois = "SOLVE_DSIMPLEX"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub dualofprimal_Click()
On Error GoTo xit
    copt = "Dual Of Primal"
Call lpp_load(False, combopid)
chois = "DUAL"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub editap_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Assignment Problem"
Call tpp_load(False, combopid)
chois = "EAP"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub editlpp_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Linear Programming Problem"
Call lpp_load(False, combopid)
chois = "ELPP"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub edittp_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Transportation Problem"
Call tpp_load(True, combopid)
chois = "ETPP"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub


Private Sub ej2_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Sequential Problem(K-Mac 2-Job)"
Call sp_load(2, combopid)
chois = "J2"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub ekmacnjob_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Sequential Problem(K-Mac N-Job)"
Call sp_load(3, combopid)
chois = "MK"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub eleqns_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Linear System Of Equations"
Call matx_load(False, combopid)
chois = "ELINEAR"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub em3_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Sequential Problem(3-Mac K-Job)"
Call sp_load(1, combopid)
chois = "M3"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub


Private Sub ematx_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Matrix"
Call matx_load(True, combopid)
chois = "EMATX"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub Form_GotFocus()
Dim x As rat
    If combopid.Visible And combopid.Enabled And combopid.ListIndex <> -1 Then
        Call combopid_Click
    End If
End Sub


Private Sub Form_Resize()
Dim i As Long

If Not very_start Then
    Call Form_load
    very_start = True
End If
Line1(0).x1 = 0
Line1(0).x2 = Me.Width
Line1(1).x1 = 0
Line1(1).x2 = Me.Width

fpid.left = IIf((((Me.ScaleWidth - fpid.Width) / 2) - 0) > 0, ((Me.ScaleWidth - fpid.Width) / 2) - 0, 5)
rtf.left = 50
rtf.Top = fpid.Top + fpid.Height + 75
rtf.Width = IIf(Me.ScaleWidth - 35 > 0, Me.ScaleWidth - 35, 35)
rtf.Height = IIf(orstat.Top - rtf.Top - 8 > 0, orstat.Top - rtf.Top - 8, 8) 'IIf(Me.ScaleHeight - fpid.Height - 10 - 5 > 0, Me.ScaleHeight - fpid.Height - 10 - 5, 5)
pic.left = rtf.left
pic.Top = rtf.Top
pic.Width = rtf.Width
pic.Height = rtf.Height
Call pic.PaintPicture(pic1.Picture, 0, 0, pic.ScaleWidth, pic.ScaleHeight)  '///, pic.ScaleWidth, pic.ScaleHeight, 0, 0, pic1.ScaleWidth, pic1.ScaleHeight)
Call initialize_animation
pbar.left = rtf.left + 25
pbar.Top = IIf(orstat.Top - pbar.Height - 40 > 0, orstat.Top - pbar.Height - 40, 10)
pbar.Visible = False
'pic.ForeColor = RGB(10, 110, 250)
'pic.FontBold = True
'pic.FontTransparent = True
'pic.FontSize = 45
'For i = 0 To Screen.FontCount Step 1
    'If LCase(Screen.Fonts(i)) = LCase("Bookman old style") Then
     '   pic.FontName = "Bookman old style"
      '  Exit For
    'End If
'Next i
'If i > Screen.FontCount Then
'    pic.FontName = Screen.Fonts(3)
'End If
'pic.CurrentX = 300
'pic.CurrentY = 350
'pic.FontItalic = True
'pic.Print "OpTech"
'pic.FontItalic = False
'pic.FontSize = 20
'pic.ForeColor = RGB(0, 0, 250)
'pic.CurrentX = 1000
'pic.CurrentY = 2150
'pic.Print "An Elegent & Simple"
'pic.CurrentX = 2000
'pic.CurrentY = 3600
'pic.Print "Approach To"
'pic.CurrentX = 3000
'pic.CurrentY = 5200
'pic.Print "Operations Research Problems!!!"
End Sub


Private Sub Form_Unload(cancel As Integer)
Dim Form As Form
    
    For Each Form In Forms
        Unload Form
    Next Form

   '---------------remove to change demo
    Dim tmp As Double
    If GetSetting("MyComputer\HKEY_CURRENT_USER\System\common\tvadel", "critic", "cval", "0") = "0" Then
            Call SaveSetting("MyComputer\HKEY_CURRENT_USER\System\common\tvadel", "critic", "cval", "0")
    End If
    time2 = Time$
    tmp = CDbl(GetSetting("MyComputer\HKEY_CURRENT_USER\System\common\tvadel", "critic", "cval", "0"))
    tmp = tmp + CDbl(Abs(DateDiff("s", time2, time1)))
    Call SaveSetting("MyComputer\HKEY_CURRENT_USER\System\common\tvadel", "critic", "cval", Trim(str(tmp)))
    '------------------------------------
End Sub



Private Sub j2_Click()
On Error GoTo xit
copt = ""
speditor.isedit = False
speditor.s_type = "J2"
speditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub kmacnjob_Click()
On Error GoTo xit
copt = ""
speditor.isedit = False
speditor.s_type = "MK"
speditor.Show
   Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub lppgraph_Click()
On Error GoTo xit
copt = "Graphical Method To Lpp"
Call lpp_load(True, combopid)
chois = "LPPG"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub lsoe_Click()
On Error GoTo xit

    r.hold = 3
    r.flg = 9
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub m2_Click()
On Error GoTo xit
copt = ""
speditor.isedit = False
speditor.s_type = "M2"
speditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub m3_Click()
On Error GoTo xit
copt = ""
speditor.isedit = False
speditor.s_type = "M3"
speditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub em2_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Edit Sequential Problem(2-Mac K-Job)"
Call sp_load(0, combopid)
chois = "M2"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub Form_load()
On Error GoTo xit

   very_start = False
   copt = ""
   orstat.Panels(1).Text = "Please select an option!"
   rtf.RightMargin = 100000
   App.HelpFile = App.path + "\Help\Myhelp.hlp"
   Call enable_cntrls(False)
   Call enable_menu_properly(0)
   Call Form_GotFocus
   opts.Visible = False
   Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub matminmethod_Click()
On Error GoTo xit
copt = "Matrix Minimum Method"
Call tpp_load(True, combopid)
chois = "MMM"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub hungary_Click()
On Error GoTo xit
copt = "Hungarian Assignment Method"
Call tpp_load(False, combopid)
chois = "AP"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub integerprgmming_Click()
On Error GoTo xit
    
    copt = "Gomery's Method"
    Call lpp_load(False, combopid)
    chois = "SOLVE_GOMERY"
    Exit Sub
xit:
    Call error_me(Me)
    
End Sub


Public Sub enable_cntrls(enable As Boolean)
On Error GoTo xit

    fpid.Enabled = enable
    ccancel.Enabled = enable
    'combopid.BackColor = IIf(enable, 16761024, -2147483644)
    If Not enable Then
        combopid.clear
        copt.Caption = ""
    End If
    combopid.Enabled = enable
    pidok.Enabled = False
    orstat.Visible = True
    If Not enable Then
        rtf.Text = "  " + vbCrLf + vbCrLf + "       NO ITEMS TO SHOW!!! " + vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 9)
        rtf.Visible = False
        pic.Visible = True
    End If
    Exit Sub
xit:
    Call error_me(Me)
End Sub



Private Sub mehlpfile_Click()
Dim retval As Long
        'Call AppActivate(App.path + "\" + App.EXEName)
        'Call SendKeys("{F1}")
        retval = WinHelp(Me.hwnd, App.path + "\HELP\MYHELP.HLP", &H3&, CLng(0))
End Sub

Private Sub mintprogramming_Click()
On Error GoTo xit
    
    copt = "Mixed Integer Problem"
    Call lpp_load(False, combopid)
    chois = "SOLVE_MIXED"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub newap_Click()
On Error GoTo xit
copt = ""
Call enable_cntrls(False)
tppeditor.is_tp = False
tppeditor.Tppedit = False
tppeditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub newtp_Click()
On Error GoTo xit
copt = ""
Call enable_cntrls(False)
tppeditor.is_tp = True
tppeditor.Tppedit = False
tppeditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub




Private Sub nleqns_Click()
On Error GoTo xit
copt = ""
Call enable_cntrls(False)
matxeditor.ismatx = False
matxeditor.isedit = False
matxeditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
        
End Sub

Private Sub nlpp_Click()
On Error GoTo xit
copt = ""
Call enable_cntrls(False)
lppeditor.lppedit = False
lppeditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub nmatx_Click()
On Error GoTo xit
copt = ""
Call enable_cntrls(False)
matxeditor.ismatx = True
matxeditor.isedit = False
matxeditor.Show
Me.Hide
Exit Sub
xit:
    Call error_me(Me)
        
End Sub

Private Sub nwcr_Click()
On Error GoTo xit
copt = "North West Corner Method"
Call tpp_load(True, combopid)
chois = "NWCR"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub






Private Sub pidok_Click()
On Error GoTo xit
Dim gr As New grapher
Dim org As matrix
Dim cnst As matrix
Dim sol As matrix
Dim tmp As matrix
Dim inv As matrix
Dim i As Long
Dim det As rat
Dim td As rat

    If chois = "CRAMER" Then
        Call create_linear_eqns(Val(combopid), org, cnst)
        det = detof(org.matx, org.rows, org.cols)
        If rat_neq0(rat_stg(det)) Then
            sol.rows = 1
            sol.cols = org.cols
            ReDim sol.matx(1, org.cols - 1)
            For i = 0 To org.cols - 1 Step 1
                tmp = org
                Call replace_column(tmp, i, cnst)
                td = detof(tmp.matx, tmp.rows, tmp.cols)
                sol.matx(0, i) = string_rat(ratdiv(rat_stg(td), rat_stg(det)))
            Next i
        Else
            sol.rows = 0
            sol.cols = 0
        End If
        Call create_matrix(Val(combopid), org)
        tmp1_matx = org
        tmp2_matx = sol
        r.hold = 3
        r.flg = 8
        r.Show vbModal, Me
        'me.hide
    End If
    
    If chois = "XINVAB" Then
        Call create_linear_eqns(Val(combopid), org, cnst)
        det = detof(org.matx, org.rows, org.cols)
        If rat_neq0(rat_stg(det)) Then
            Call invof(org.matx, org.rows, org.cols, inv.matx, inv.rows, inv.cols)
            Call matmul(inv.matx, inv.rows, inv.cols, cnst.matx, cnst.rows, cnst.cols, tmp.matx, tmp.rows, tmp.cols)
            Call transposeof(tmp.matx, tmp.rows, tmp.cols, sol.matx, sol.rows, sol.cols)
        Else
            sol.rows = 0
            sol.cols = 0
        End If
        Call create_matrix(Val(combopid), org)
        tmp1_matx = org
        tmp2_matx = sol
        r.hold = 3
        r.flg = 10
        r.Show vbModal, Me
        'me.hide
    End If
    If chois = "LPPG" Then
        gr.hold = 1
        gr.indx = Val(combopid)
        gr.Show vbModal, Me
        'Me.Hide
        Exit Sub
    End If
    
    If chois = "BBM" Then
        mdi.hold = 0
        mdi.chois = "BBM"
        mdi.pid = Val(combopid)
        mdi.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "SOLVE_SIMPLEX" Then
        lpp_solve.hold = 0
        lpp_solve.type_solve = "SOLVE_SIMPLEX"
        lpp_solve.pid = Val(combopid)
        lpp_solve.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "DUAL" Then
        lpp_solve.hold = 0
        lpp_solve.type_solve = "DUAL"
        lpp_solve.pid = Val(combopid)
        lpp_solve.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "SOLVE_GOMERY" Then
        lpp_solve.hold = 0
        lpp_solve.type_solve = "SOLVE_GOMERY"
        lpp_solve.pid = Val(combopid)
        lpp_solve.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "SOLVE_DSIMPLEX" Then
        lpp_solve.hold = 0
        lpp_solve.type_solve = "SOLVE_DSIMPLEX"
        lpp_solve.pid = Val(combopid)
        lpp_solve.Show
        Me.Hide
        Exit Sub
    End If
     
    If chois = "SOLVE_MIXED" Then
        lpp_solve.hold = 0
        lpp_solve.type_solve = "SOLVE_MIXED"
        lpp_solve.pid = Val(combopid)
        lpp_solve.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "ELPP" Then
        lppeditor.lppedit = True
        lppeditor.lpp_id = Val(combopid)
        lppeditor.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "DLPP" Then
        If MsgBox("Are you sure to delete?", vbYesNo, "Delete Confirm!!!") = vbNo Then
            Exit Sub
        End If
        Call connect
        dn.cn.BeginTrans
        Call delete_record("lpp_sub2", "pid", Val(combopid), True, False)
        Call delete_record("lpp_sub1", "pid", Val(combopid), True, False)
        Call delete_record("lpp_main", "pid", Val(combopid), True, False)
        dn.cn.CommitTrans
        rtf = ""
        Call dlpp_Click
        Exit Sub
    End If
     
    If chois = "DTPP" Or chois = "DAP" Then
        If MsgBox("Are you sure to delete?", vbYesNo, "Delete Confirm!!!") = vbNo Then
            Exit Sub
        End If
        Call connect
        dn.cn.BeginTrans
        Call delete_record("tpp_sub2", "tid", Val(combopid), True, False)
        Call delete_record("tpp_sub1", "tid", Val(combopid), True, False)
        Call delete_record("tpp_main", "tid", Val(combopid), True, False)
        dn.cn.CommitTrans
        rtf = ""
        If chois = "DAP" Then
            Call dap_Click
        ElseIf chois = "DTPP" Then
            Call dtpp_Click
        End If
        Exit Sub
    End If
       
    If chois = "ETPP" Then
        tppeditor.Tppedit = True
        tppeditor.Tpp_id = Val(combopid)
        tppeditor.is_tp = True
        tppeditor.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "EAP" Then
        tppeditor.Tppedit = True
        tppeditor.Tpp_id = Val(combopid)
        tppeditor.is_tp = False
        tppeditor.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "EMATX" Then
        matxeditor.ismatx = True
        matxeditor.isedit = True
        matxeditor.m_id = Val(combopid)
        matxeditor.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "ELINEAR" Then
        matxeditor.ismatx = False
        matxeditor.isedit = True
        matxeditor.m_id = Val(combopid)
        matxeditor.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "DLINEAR" Or chois = "DMATX" Then
        If MsgBox("Are you sure to delete?", vbYesNo, "Delete Confirm!!!") = vbNo Then
            Exit Sub
        End If
        Call connect
        dn.cn.BeginTrans
        Call delete_record("matx_sub1", "matxid", Val(combopid), True, False)
        Call delete_record("matx_main", "matxid", Val(combopid), True, False)
        dn.cn.CommitTrans
        rtf = ""
        If chois = "DLINEAR" Then
            Call dlsoe_Click
        ElseIf chois = "DMATX" Then
            Call dm_Click
        End If
        Exit Sub
    End If
    
    If chois = "VAM" Then
        tpsolver.hold = 0
        tpsolver.method = "VAM"
        tpsolver.metid = Val(combopid)
        tpsolver.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "NWCR" Then
        tpsolver.hold = 0
        tpsolver.method = "NWCR"
        tpsolver.metid = Val(combopid)
        tpsolver.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "MMM" Then
        tpsolver.hold = 0
        tpsolver.method = "MMM"
        tpsolver.metid = Val(combopid)
        tpsolver.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "AP" Then
        apsolver.hold = 0
        apsolver.Ap_id = Val(combopid)
        apsolver.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "MATX1" Then
        matx1.hold = 0
        matx1.id_ = Val(combopid)
        matx1.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "MATX21" Then
        matx2.hold = 0
        matx2.opt = 0
        matx2.id_ = Val(combopid)
        matx2.Show
        Me.Hide
        Exit Sub
    End If
     If chois = "MATX211" Then
        matx2.hold = 0
        matx2.opt = 1
        matx2.id_ = Val(combopid)
        matx2.Show
        Me.Hide
        Exit Sub
    End If
    If chois = "M2" Or chois = "M3" Or chois = "J2" Or chois = "MK" Then
        speditor.isedit = True
        speditor.sid = Val(combopid)
        speditor.s_type = chois
        speditor.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "DM2" Or chois = "DM3" Or chois = "DJ2" Or chois = "DMK" Then
        If MsgBox("Are you sure to delete?", vbYesNo, "Delete Confirm!!!") = vbNo Then
            Exit Sub
        End If
        Call connect
        dn.cn.BeginTrans
        Call delete_record("sp_sub1", "sid", Val(combopid), True, False)
        Call delete_record("sp_main", "sid", Val(combopid), True, False)
        dn.cn.CommitTrans
        rtf = ""
        If chois = "DM2" Then
            Call d2mkj_Click
        ElseIf chois = "DM3" Then
            Call d3mkj_Click
        ElseIf chois = "DJ2" Then
            Call dkm2j_Click
        ElseIf chois = "DMK" Then
            Call dkmnj_Click
        End If
    End If
    
    If chois = "SM2" Or chois = "SM3" Or chois = "SMK" Then
        spsolver.hold = 0
        spsolver.s_type = chois
        spsolver.sp_id = Val(combopid)
        spsolver.Show
        Me.Hide
        Exit Sub
    End If
    
    If chois = "SJ2" Then
        spj2.hold = 0
        spj2.spj2id = Val(combopid)
        spj2.Show
        Me.Hide
        Exit Sub
    End If
    
Exit Sub
xit:
    Call error_me(Me)
    
End Sub



Private Sub rcfom_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Find Row Canonical Form Of Matrix"
Call matx_load(True, combopid)
chois = "MATX211"
Exit Sub
xit:
    Call error_me(Me)
End Sub



Private Sub reda_Click()

    If MsgBox("Reassigning will disconnect the connection, " + vbCrLf + "between OpTech and the database currently using." _
    + vbCrLf + vbCrLf + "Are you sure to continue?", vbYesNo, "Confirm database disconnection!!!") = vbYes Then
        Unload Me
        Call del_registry
        MsgBox "OpTech will now restart.", vbOKOnly, "Restart Optech"
        frmSplash.Show
    Else
        Exit Sub
    End If
End Sub

Private Sub rom_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Find Rank Of Matrix"
Call matx_load(True, combopid)
chois = "MATX21"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub simplex_Click()
On Error GoTo xit
    copt = "Simplex Method"
    Call lpp_load(False, combopid)
    chois = "SOLVE_SIMPLEX"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Function lpp_load(forgraph As Boolean, combopid As ComboBox) As Boolean
'On Error GoTo xit
Dim Y As New Recordset
 
    lpp_load = False
    Call connect
    rtf.Text = "  " + vbCrLf + vbCrLf + "       NO ITEMS TO SHOW!!! " + vbCrLf
    rtf.Visible = False
    pic.Visible = True
    Call formattextinrtf(rtf, " ", "COURIER NEW", 9)
    Set Y = dn.cn.Execute("select pid from lpp_main " & IIf(forgraph, " where n=2", "") & " order by pid")
    If Y.RecordCount <= 0 Then
        Call enable_cntrls(False)
        lpp_load = False
    Else
        Call addtocombobox(combopid, Y, "pid")
        Call enable_cntrls(True)
        If Me.Visible And combopid.Visible And combopid.Enabled Then combopid.SetFocus
        lpp_load = True
    End If

'Exit Function
'xit:
    'lpp_load = False
    'Call error_me(Me)
End Function

Private Function sp_load(s_type As Integer, combopid As ComboBox) As Boolean
'On Error GoTo xit
Dim Y As New Recordset
 
    sp_load = False
    Call connect
    rtf.Text = "  " + vbCrLf + vbCrLf + "       NO ITEMS TO SHOW!!! " + vbCrLf
    rtf.Visible = False
    pic.Visible = True
    Call formattextinrtf(rtf, " ", "COURIER NEW", 9)
    Set Y = dn.cn.Execute("select sid from sp_main where s_type='" & IIf(s_type = 0, "M2", IIf(s_type = 1, "M3", IIf(s_type = 2, "J2", "MK"))) & "' order by sid")
    If Y.RecordCount <= 0 Then
        Call enable_cntrls(False)
        sp_load = False
    Else
        Call addtocombobox(combopid, Y, "sid")
        Call enable_cntrls(True)
        If Me.Visible And combopid.Visible And combopid.Enabled Then combopid.SetFocus
        sp_load = True
    End If
'Exit Function
'xit:
 '   sp_load = False
  '  Call error_me(Me)
End Function

Private Function tpp_load(istp As Boolean, combopid As ComboBox) As Boolean
'On Error GoTo xit
Dim Y As New Recordset
    
    tpp_load = False
    Call connect
    rtf.Text = "  " + vbCrLf + vbCrLf + "       NO ITEMS TO SHOW!!! " + vbCrLf
    rtf.Visible = False
    pic.Visible = True
    Call formattextinrtf(rtf, " ", "COURIER NEW", 9)
    Set Y = dn.cn.Execute("select tid from tpp_main where tora='" & IIf(istp, "T", "A") & "' order by tid")
    If Y.RecordCount <= 0 Then
        Call enable_cntrls(False)
        tpp_load = False
    Else
        Call addtocombobox(combopid, Y, "tid")
        Call enable_cntrls(True)
        If Me.Visible And combopid.Visible And combopid.Enabled Then combopid.SetFocus
        tpp_load = True
    End If
'Exit Function
'xit:
 '   Call error_me(Me)
  '  tpp_load = False
End Function

Private Function matx_load(ismatx As Boolean, combopid As ComboBox) As Boolean
'On Error GoTo xit
Dim Y As New Recordset
 
    matx_load = False
    Call connect
    rtf.Text = "  " + vbCrLf + vbCrLf + "       NO ITEMS TO SHOW!!! " + vbCrLf
    rtf.Visible = False
    pic.Visible = True
    Call formattextinrtf(rtf, " ", "COURIER NEW", 9)
    Set Y = dn.cn.Execute("select matxid from matx_main" + IIf(Not ismatx, " where cs>=2 ", " ") + "order by matxid")
    If Y.RecordCount <= 0 Then
        Call enable_cntrls(False)
        matx_load = False
    Else
        Call addtocombobox(combopid, Y, "matxid")
        Call enable_cntrls(True)
        If Me.Visible And combopid.Visible And combopid.Enabled Then combopid.SetFocus
        matx_load = True
    End If

'Exit Function
'xit:
    'matx_load = False
    'Call error_me(Me)
End Function

Private Sub sj2_Click()
On Error GoTo xit
copt = "Solve Sequential Problem(K-Mac 2-Job)"
Call sp_load(2, combopid)
chois = "SJ2"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub skmacnjob_Click()
On Error GoTo xit
copt = "Solve Sequential Problem(K-Mac N-Job)"
Call sp_load(3, combopid)
chois = "SMK"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub sm2_Click()
On Error GoTo xit
copt = "Solve Sequential Problem(2-Mac K-Job)"
Call sp_load(0, combopid)
chois = "SM2"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub sm3_Click()
On Error GoTo xit
copt = "Solve Sequential Problem(3-Mac K-Job)"
Call sp_load(1, combopid)
chois = "SM3"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub tdc_Click()
On Error GoTo xit
    

    If Format(Date, "mm/dd/yyyy") <> CStr(Date) Then
        MsgBox "Change date format to mm/dd/yyyy in your control panel", vbYes, "OpTech, unsupportable dateformat found!"
        Exit Sub
    End If
    ftools.HelpContextID = 21
    ftools.cexit.Visible = True
    ftools.Caption = "Date Calculator"
    ftools.datecalculatordemo21.Visible = True
    ftools.Label3.Visible = True
    ftools.Label1.Visible = False
    ftools.Label2.Visible = False
    ftools.c1.Visible = False
    ftools.c2.Visible = False
    ftools.c3.Visible = False
    ftools.t1.Visible = False
    ftools.t2.Visible = False
    ftools.opts.Visible = False
    ftools.Height = 5480
    ftools.Width = 4630
    ftools.Show vbModal, Me
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub timer1_Timer()
   Dim i As Integer
    Dim j As Integer
    Dim tmp As Double
    Dim stg As String
    
    
    For i = rmove.LBound To rmove.UBound Step 1
        If toright(i) = False Then
            tmp = rmove(i).left - 20
            If tmp <= 20 Then
                toright(i) = True
                rmove(i).left = 20
            Else
                rmove(i).left = tmp
            End If
         Else
            tmp = rmove(i).left + 20
            If tmp >= (Me.ScaleWidth - 300) Then
                toright(i) = False
                rmove(i).left = (Me.ScaleWidth - 300)
            Else
                rmove(i).left = tmp
            End If
         End If
    
         For j = rmove.LBound To rmove.UBound Step 1
            If i <> j And ((rmove(i).left >= rmove(j).left And rmove(i).left <= rmove(j).left + 20) Or (rmove(j).left >= rmove(i).left And rmove(j).left <= rmove(i).left + 20)) Then
                stg = rmove(i).Caption
                rmove(i).Caption = rmove(j).Caption
                rmove(j).Caption = stg
            End If
         Next j
    Next i
End Sub





Private Sub vam_Click()
On Error GoTo xit
    copt = "VAM Method"
Call tpp_load(True, combopid)
chois = "VAM"
Exit Sub
xit:
    Call error_me(Me)
    
End Sub


Private Sub print_Click()
On Error GoTo cancel
Dim i As Integer

If Trim(rtf) <> "" Then
    rtf.SelStart = 1
    rtf.SelLength = Len(rtf)
    dialog1.PrinterDefault = True
    dialog1.ShowPrinter
    For i = 1 To dialog1.Copies
        Printer.NewPage
        rtf.SelPrint (Printer.hDC)
    Next i
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub rtf_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
If Button = vbRightButton Then
    If Trim(rtf) <> "" Then
        If rtf.SelText <> "" Then
            Clipboard.SetText ("")
            cpy.Enabled = True
        Else
            cpy.Enabled = False
        End If
        PopupMenu opts
    End If
  End If
End Sub

Private Sub savtofile_Click()
On Error GoTo cancel

If Trim(rtf.Text) <> "" Then
    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800
    dialog1.ShowSave
    rtf.SaveFile dialog1.FileName, rtfRTF
    Exit Sub
Else
    Exit Sub
End If

cancel:
   MsgBox Err.Description
End Sub

Private Sub cpy_Click()
On Error GoTo x
    If rtf.SelText <> "" Then
        Clipboard.SetText rtf.SelText, vbCFRTF
    End If
Exit Sub
x:
    MsgBox Err.Description
End Sub

Private Sub xinvabrule_Click()
On Error GoTo xit
Call enable_cntrls(False)
copt = "Apply X=Inverse(A)xB Rule"
Call matx_load(False, combopid)
chois = "XINVAB"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub xit_Click()
    Unload Me
End Sub

Public Sub enable_menu_properly(item As Long)
'On Error GoTo xit

If item = 0 Or item = 1 Then
   If Not lpp_load(False, tcomb) Then
        editlpp.Enabled = False
        dlpp.Enabled = False
        simplex.Enabled = False
        dual_simplex.Enabled = False
        integerprgmming.Enabled = False
        mintprogramming.Enabled = False
        dualofprimal.Enabled = False
        bbmethod.Enabled = False
    Else
        editlpp.Enabled = True
        dlpp.Enabled = True
        simplex.Enabled = True
        dual_simplex.Enabled = True
        integerprgmming.Enabled = True
        mintprogramming.Enabled = True
        dualofprimal.Enabled = True
        bbmethod.Enabled = True
   End If
   If Not lpp_load(True, tcomb) Then
        lppgraph.Enabled = False
   Else
        lppgraph.Enabled = True
   End If
   If simplex.Enabled = False And lppgraph.Enabled = False Then
        lpp.Enabled = False
    Else
        lpp.Enabled = True
   End If
End If

If item = 0 Or item = 2 Then
   If Not tpp_load(True, tcomb) Then
        edittp.Enabled = False
        dtpp.Enabled = False
        tp.Enabled = False
   Else
        edittp.Enabled = True
        dtpp.Enabled = True
        tp.Enabled = True
   End If
End If

If item = 0 Or item = 3 Then
   If Not tpp_load(False, tcomb) Then
        editap.Enabled = False
        dap.Enabled = False
        ap.Enabled = False
   Else
        editap.Enabled = True
        dap.Enabled = True
        ap.Enabled = True
   End If
End If

If item = 0 Or item = 4 Then
    If Not matx_load(True, tcomb) Then
        ematx.Enabled = False
        dm.Enabled = False
        smatx.Enabled = False
    Else
        ematx.Enabled = True
        dm.Enabled = True
        smatx.Enabled = True
    End If
End If

If item = 0 Or item = 5 Then
    If Not matx_load(False, tcomb) Then
        eleqns.Enabled = False
        dlsoe.Enabled = False
        alsoe.Enabled = False
    Else
        eleqns.Enabled = True
        dlsoe.Enabled = True
        alsoe.Enabled = True
    End If
End If

If item = 0 Or item = 6 Then
    If Not sp_load(0, tcomb) Then
        em2.Enabled = False
        d2mkj.Enabled = False
        sm2.Enabled = False
    Else
        em2.Enabled = True
        d2mkj.Enabled = True
        sm2.Enabled = True
    End If
End If

If item = 0 Or item = 7 Then
    If Not sp_load(1, tcomb) Then
        em3.Enabled = False
        d3mkj.Enabled = False
        sm3.Enabled = False
    Else
        em3.Enabled = True
        d3mkj.Enabled = True
        sm3.Enabled = True
    End If
End If

If item = 0 Or item = 8 Then
    If Not sp_load(2, tcomb) Then
        ej2.Enabled = False
        dkm2j.Enabled = False
        sj2.Enabled = False
    Else
        ej2.Enabled = True
        dkm2j.Enabled = True
        sj2.Enabled = True
    End If
End If

If item = 0 Or item = 9 Then
    If Not sp_load(3, tcomb) Then
        ekmacnjob.Enabled = False
        dkmnj.Enabled = False
        skmacnjob.Enabled = False
    Else
        ekmacnjob.Enabled = True
        dkmnj.Enabled = True
        skmacnjob.Enabled = True
    End If
End If

If Not em2.Enabled And Not em3.Enabled And Not ej2.Enabled And Not ekmacnjob.Enabled Then
    spsolve.Enabled = False
    editsp.Enabled = False
    dsp.Enabled = False
Else
    spsolve.Enabled = True
    editsp.Enabled = True
    dsp.Enabled = True
End If

If item = 0 Then Call enable_cntrls(False)

            '---------------remove to change demo
                        newap.Enabled = False
                        newsp.Enabled = False
                        editap.Enabled = False
                        editsp.Enabled = False
                        dap.Enabled = False
                        dsp.Enabled = False
                        ap.Enabled = False
                        spsolve.Enabled = False
                        allapp.Enabled = False
                        allsp.Enabled = False
                        tdc.Enabled = False
            '--------------------------end-----------

'Exit Sub
'xit:
    'Call error_me(Me)
End Sub

Private Sub initialize_animation()
Dim i As Integer

initials(0) = "O"
initials(1) = "p"
initials(2) = "T"
initials(3) = "e"
initials(4) = "c"
initials(5) = "h"

For i = rmove.LBound To rmove.UBound
    rmove(i).left = 600 + 480 * i
    'rmove(i).Top = 735
    rmove(i).Width = 375
    rmove(i).Height = 375
    rmove(i).Caption = initials(i)
    toright(i) = False
    rmove(i).Enabled = False
Next i
End Sub

