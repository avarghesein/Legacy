VERSION 5.00
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form Scientific 
   Caption         =   "ScienTech.1.0"
   ClientHeight    =   4695
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   8010
   Icon            =   "Calculator.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4695
   ScaleWidth      =   8010
   StartUpPosition =   1  'CenterOwner
   Begin MSComDlg.CommonDialog dialog1 
      Left            =   2880
      Top             =   1320
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Frame fnmem 
      Height          =   870
      Left            =   4155
      TabIndex        =   61
      Top             =   3780
      Width           =   2400
      Begin MSForms.CommandButton cm 
         Height          =   720
         Index           =   4
         Left            =   975
         TabIndex        =   66
         Top             =   120
         Width           =   465
         ForeColor       =   -2147483647
         Caption         =   "M"
         Size            =   "820;1270"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cm 
         Height          =   720
         Index           =   3
         Left            =   1905
         TabIndex        =   65
         Top             =   120
         Width           =   465
         ForeColor       =   -2147483647
         Caption         =   "MC"
         Size            =   "820;1270"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cm 
         Height          =   720
         Index           =   2
         Left            =   1440
         TabIndex        =   64
         Top             =   120
         Width           =   465
         ForeColor       =   -2147483647
         Caption         =   "MR"
         Size            =   "820;1270"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cm 
         Height          =   720
         Index           =   1
         Left            =   45
         TabIndex        =   63
         Top             =   120
         Width           =   465
         ForeColor       =   -2147483647
         Caption         =   "M-"
         Size            =   "820;1270"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cm 
         Height          =   720
         Index           =   0
         Left            =   510
         TabIndex        =   62
         Top             =   120
         Width           =   465
         ForeColor       =   -2147483647
         Caption         =   "M+"
         Size            =   "820;1270"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
   End
   Begin VB.Frame fansmem 
      Height          =   510
      Left            =   3540
      TabIndex        =   34
      Top             =   1185
      Width           =   3075
      Begin MSForms.CommandButton cansmem 
         Height          =   360
         Index           =   2
         Left            =   2310
         TabIndex        =   37
         Top             =   120
         Width           =   735
         ForeColor       =   8388608
         Caption         =   "<"
         Size            =   "1296;635"
         Accelerator     =   60
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cansmem 
         Height          =   360
         Index           =   1
         Left            =   1170
         TabIndex        =   36
         Top             =   120
         Width           =   1155
         ForeColor       =   8388608
         Caption         =   "Next"
         Size            =   "2037;635"
         Accelerator     =   110
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cansmem 
         Height          =   360
         Index           =   0
         Left            =   15
         TabIndex        =   35
         Top             =   120
         Width           =   1155
         ForeColor       =   8388608
         Caption         =   "Previous"
         Size            =   "2037;635"
         Accelerator     =   112
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
   End
   Begin VB.Frame fmem 
      Height          =   3090
      Left            =   6690
      TabIndex        =   67
      Top             =   1110
      Width           =   1305
      Begin MSForms.Frame Frame1 
         Height          =   45
         Index           =   1
         Left            =   60
         OleObjectBlob   =   "Calculator.frx":0442
         TabIndex        =   82
         Top             =   975
         Width           =   1185
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   8
         Left            =   135
         TabIndex        =   79
         Top             =   2625
         Width           =   1005
         ForeColor       =   -2147483647
         Caption         =   "ANS"
         Size            =   "1773;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.OptionButton omem 
         Height          =   270
         Index           =   2
         Left            =   120
         TabIndex        =   70
         Top             =   690
         Width           =   1020
         BackColor       =   -2147483633
         ForeColor       =   128
         DisplayStyle    =   5
         Size            =   "1799;476"
         Value           =   "0"
         Caption         =   "Select"
         Accelerator     =   116
         GroupName       =   "memfun"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   7
         Left            =   720
         TabIndex        =   78
         Top             =   2220
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "H"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   6
         Left            =   150
         TabIndex        =   77
         Top             =   2220
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "G"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   5
         Left            =   720
         TabIndex        =   76
         Top             =   1830
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "F"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   4
         Left            =   150
         TabIndex        =   75
         Top             =   1830
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "E"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   3
         Left            =   720
         TabIndex        =   74
         Top             =   1440
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "D"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   2
         Left            =   150
         TabIndex        =   73
         Top             =   1440
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "C"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   1
         Left            =   720
         TabIndex        =   72
         Top             =   1050
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "B"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmem 
         Height          =   390
         Index           =   0
         Left            =   150
         TabIndex        =   71
         Top             =   1050
         Width           =   420
         ForeColor       =   -2147483647
         Caption         =   "A"
         Size            =   "741;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.OptionButton omem 
         Height          =   270
         Index           =   1
         Left            =   120
         TabIndex        =   69
         Top             =   405
         Width           =   1020
         BackColor       =   -2147483633
         ForeColor       =   128
         DisplayStyle    =   5
         Size            =   "1799;476"
         Value           =   "0"
         Caption         =   "Recall"
         Accelerator     =   108
         GroupName       =   "memfun"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin MSForms.OptionButton omem 
         Height          =   270
         Index           =   0
         Left            =   120
         TabIndex        =   68
         Top             =   120
         Width           =   1020
         BackColor       =   -2147483633
         ForeColor       =   128
         DisplayStyle    =   5
         Size            =   "1799;476"
         Value           =   "0"
         Caption         =   "Store"
         Accelerator     =   115
         GroupName       =   "memfun"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
   End
   Begin VB.Frame cfuns 
      Height          =   2100
      Left            =   4995
      TabIndex        =   52
      Top             =   1680
      Width           =   1605
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   7
         Left            =   795
         TabIndex        =   58
         Top             =   1095
         Width           =   690
         ForeColor       =   32768
         Caption         =   "int"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   6
         Left            =   795
         TabIndex        =   60
         Top             =   1530
         Width           =   690
         ForeColor       =   32768
         Caption         =   "!"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   5
         Left            =   90
         TabIndex        =   59
         Top             =   1530
         Width           =   690
         ForeColor       =   32768
         Caption         =   "inv"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   4
         Left            =   795
         TabIndex        =   54
         Top             =   195
         Width           =   690
         ForeColor       =   32768
         Caption         =   "sqr"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   3
         Left            =   90
         TabIndex        =   53
         Top             =   195
         Width           =   690
         ForeColor       =   32768
         Caption         =   "sqrt"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   2
         Left            =   90
         TabIndex        =   57
         Top             =   1095
         Width           =   690
         ForeColor       =   32768
         Caption         =   "log"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   1
         Left            =   795
         TabIndex        =   56
         Top             =   645
         Width           =   690
         ForeColor       =   32768
         Caption         =   "exp"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton cmfun 
         Height          =   435
         Index           =   0
         Left            =   90
         TabIndex        =   55
         Top             =   645
         Width           =   690
         ForeColor       =   32768
         Caption         =   "ln"
         Size            =   "1217;767"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
   End
   Begin VB.Frame foperators 
      Height          =   1605
      Left            =   2040
      TabIndex        =   38
      Top             =   1845
      Width           =   2880
      Begin MSForms.Label Label1 
         Height          =   405
         Index           =   1
         Left            =   2235
         TabIndex        =   84
         Top             =   1095
         Width           =   480
         Size            =   "847;714"
         SpecialEffect   =   6
         FontHeight      =   165
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin MSForms.Label Label1 
         Height          =   405
         Index           =   0
         Left            =   2250
         TabIndex        =   83
         Top             =   210
         Width           =   480
         Size            =   "847;714"
         SpecialEffect   =   6
         FontHeight      =   165
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   12
         Left            =   2235
         TabIndex        =   51
         Top             =   645
         Width           =   495
         ForeColor       =   255
         Caption         =   "->"
         Size            =   "873;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   11
         Left            =   1710
         TabIndex        =   50
         Top             =   1080
         Width           =   495
         ForeColor       =   255
         Caption         =   "<-"
         Size            =   "873;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   9
         Left            =   1710
         TabIndex        =   46
         Top             =   645
         Width           =   510
         ForeColor       =   255
         Caption         =   "nPr"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   8
         Left            =   1710
         TabIndex        =   42
         Top             =   210
         Width           =   510
         ForeColor       =   255
         Caption         =   "nCr"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   10
         Left            =   1185
         TabIndex        =   49
         Top             =   1080
         Width           =   510
         ForeColor       =   255
         Caption         =   "="
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   7
         Left            =   1185
         TabIndex        =   45
         Top             =   645
         Width           =   510
         ForeColor       =   255
         Caption         =   "e"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   6
         Left            =   660
         TabIndex        =   48
         Top             =   1080
         Width           =   510
         ForeColor       =   255
         Caption         =   "div"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   5
         Left            =   135
         TabIndex        =   47
         Top             =   1080
         Width           =   510
         ForeColor       =   255
         Caption         =   "mod"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   4
         Left            =   660
         TabIndex        =   44
         Top             =   645
         Width           =   510
         ForeColor       =   255
         Caption         =   "^"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   3
         Left            =   135
         TabIndex        =   43
         Top             =   645
         Width           =   510
         ForeColor       =   255
         Caption         =   "%"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   2
         Left            =   1185
         TabIndex        =   41
         Top             =   210
         Width           =   510
         ForeColor       =   255
         Caption         =   "*"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   1
         Left            =   660
         TabIndex        =   40
         Top             =   210
         Width           =   510
         ForeColor       =   255
         Caption         =   "-"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coptr 
         Height          =   420
         Index           =   0
         Left            =   135
         TabIndex        =   39
         Top             =   210
         Width           =   510
         ForeColor       =   255
         Caption         =   "+"
         Size            =   "900;741"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
   End
   Begin VB.Frame foperands 
      Height          =   1125
      Left            =   45
      TabIndex        =   17
      Top             =   3510
      Width           =   3990
      Begin MSForms.CommandButton coperand 
         Height          =   885
         Index           =   15
         Left            =   3480
         TabIndex        =   33
         Top             =   165
         Width           =   420
         ForeColor       =   16711680
         Caption         =   "CE"
         Size            =   "741;1561"
         Accelerator     =   99
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   14
         Left            =   3060
         TabIndex        =   30
         Top             =   180
         Width           =   390
         ForeColor       =   16711680
         Caption         =   ")"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   13
         Left            =   2640
         TabIndex        =   29
         Top             =   180
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "("
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   885
         Index           =   12
         Left            =   2190
         TabIndex        =   28
         Top             =   165
         Width           =   420
         ForeColor       =   16711680
         Caption         =   "."
         Size            =   "741;1561"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   11
         Left            =   2640
         TabIndex        =   31
         Top             =   645
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "-"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   10
         Left            =   3060
         TabIndex        =   32
         Top             =   645
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "+"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   9
         Left            =   1770
         TabIndex        =   27
         Top             =   630
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "9"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   8
         Left            =   1335
         TabIndex        =   26
         Top             =   630
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "8"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   7
         Left            =   900
         TabIndex        =   25
         Top             =   630
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "7"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   6
         Left            =   480
         TabIndex        =   24
         Top             =   630
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "6"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   5
         Left            =   60
         TabIndex        =   23
         Top             =   630
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "5"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   4
         Left            =   1770
         TabIndex        =   22
         Top             =   165
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "4"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   3
         Left            =   1350
         TabIndex        =   21
         Top             =   165
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "3"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   2
         Left            =   930
         TabIndex        =   20
         Top             =   165
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "2"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   1
         Left            =   495
         TabIndex        =   19
         Top             =   165
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "1"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton coperand 
         Height          =   405
         Index           =   0
         Left            =   75
         TabIndex        =   18
         Top             =   165
         Width           =   390
         ForeColor       =   16711680
         Caption         =   "0"
         Size            =   "688;714"
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
   End
   Begin VB.Frame ftrignometric 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1620
      Left            =   45
      TabIndex        =   8
      Top             =   1830
      Width           =   1950
      Begin MSForms.Frame Frame1 
         Height          =   45
         Index           =   0
         Left            =   105
         OleObjectBlob   =   "Calculator.frx":0E5A
         TabIndex        =   81
         Top             =   510
         Width           =   1740
      End
      Begin MSForms.CommandButton ctrig 
         Height          =   390
         Index           =   5
         Left            =   1290
         TabIndex        =   16
         Top             =   1095
         Width           =   555
         ForeColor       =   8388736
         Caption         =   "cot"
         Size            =   "979;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton ctrig 
         Height          =   390
         Index           =   4
         Left            =   690
         TabIndex        =   15
         Top             =   1095
         Width           =   555
         ForeColor       =   8388736
         Caption         =   "sec"
         Size            =   "979;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton ctrig 
         Height          =   390
         Index           =   3
         Left            =   75
         TabIndex        =   14
         Top             =   1095
         Width           =   555
         ForeColor       =   8388736
         Caption         =   "cosec"
         Size            =   "979;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton ctrig 
         Height          =   390
         Index           =   2
         Left            =   1290
         TabIndex        =   13
         Top             =   660
         Width           =   555
         ForeColor       =   8388736
         Caption         =   "tan"
         Size            =   "979;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton ctrig 
         Height          =   390
         Index           =   1
         Left            =   690
         TabIndex        =   12
         Top             =   660
         Width           =   555
         ForeColor       =   8388736
         Caption         =   "cos"
         Size            =   "979;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CommandButton ctrig 
         Height          =   390
         Index           =   0
         Left            =   75
         TabIndex        =   11
         Top             =   660
         Width           =   555
         ForeColor       =   8388736
         Caption         =   "sin"
         Size            =   "979;688"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   3
      End
      Begin MSForms.CheckBox chyp 
         Height          =   315
         Left            =   1215
         TabIndex        =   10
         Top             =   150
         Width           =   705
         VariousPropertyBits=   746588179
         BackColor       =   -2147483633
         ForeColor       =   8388736
         DisplayStyle    =   4
         Size            =   "1244;556"
         Value           =   "0"
         Caption         =   "Hyp"
         SpecialEffect   =   0
         Accelerator     =   121
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin MSForms.CheckBox cinv 
         Height          =   315
         Left            =   75
         TabIndex        =   9
         Top             =   150
         Width           =   705
         VariousPropertyBits=   746588179
         BackColor       =   -2147483633
         ForeColor       =   8388736
         DisplayStyle    =   4
         Size            =   "1244;556"
         Value           =   "0"
         Caption         =   "Inv"
         SpecialEffect   =   0
         Accelerator     =   105
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
   End
   Begin VB.Frame frad 
      Height          =   465
      Left            =   45
      TabIndex        =   4
      Top             =   1200
      Width           =   2655
      Begin MSForms.OptionButton ordg 
         Height          =   285
         Index           =   2
         Left            =   1725
         TabIndex        =   7
         Top             =   150
         Width           =   945
         VariousPropertyBits=   746588179
         BackColor       =   -2147483633
         ForeColor       =   8388736
         DisplayStyle    =   5
         Size            =   "1667;503"
         Value           =   "0"
         Caption         =   "Gradian"
         Accelerator     =   103
         GroupName       =   "raddeggrad"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin MSForms.OptionButton ordg 
         Height          =   315
         Index           =   1
         Left            =   885
         TabIndex        =   6
         Top             =   135
         Width           =   945
         VariousPropertyBits=   746588179
         BackColor       =   -2147483633
         ForeColor       =   8388736
         DisplayStyle    =   5
         Size            =   "1667;556"
         Value           =   "0"
         Caption         =   "Degree"
         Accelerator     =   100
         GroupName       =   "raddeggrad"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
      Begin MSForms.OptionButton ordg 
         Height          =   270
         Index           =   0
         Left            =   60
         TabIndex        =   5
         Top             =   150
         Width           =   930
         VariousPropertyBits=   746588179
         BackColor       =   -2147483633
         ForeColor       =   8388736
         DisplayStyle    =   5
         Size            =   "1640;476"
         Value           =   "0"
         Caption         =   "Radian"
         Accelerator     =   114
         GroupName       =   "raddeggrad"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
   End
   Begin VB.Frame fexpres 
      Caption         =   "Expression"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   1065
      Left            =   0
      TabIndex        =   0
      Top             =   45
      Width           =   8025
      Begin MSForms.Label lans 
         Height          =   285
         Left            =   45
         TabIndex        =   2
         Top             =   690
         Width           =   690
         ForeColor       =   8388608
         VariousPropertyBits=   8388627
         Caption         =   "Answer"
         Size            =   "1217;503"
         FontName        =   "Times New Roman"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   2
      End
      Begin MSForms.TextBox tans 
         Height          =   375
         Left            =   765
         TabIndex        =   3
         Top             =   615
         Width           =   7170
         VariousPropertyBits=   746604573
         Size            =   "12647;661"
         SpecialEffect   =   6
         FontName        =   "Courier New"
         FontEffects     =   1073750016
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
         ParagraphAlign  =   2
      End
      Begin MSForms.TextBox texp 
         Height          =   360
         Left            =   60
         TabIndex        =   1
         Top             =   210
         Width           =   7890
         VariousPropertyBits=   746604571
         Size            =   "13917;635"
         SpecialEffect   =   6
         FontName        =   "Courier New"
         FontHeight      =   180
         FontCharSet     =   0
         FontPitchAndFamily=   2
      End
   End
   Begin MSForms.CommandButton cspace 
      Height          =   390
      Left            =   6675
      TabIndex        =   80
      Top             =   4260
      Width           =   1320
      ForeColor       =   12583104
      Caption         =   "Space"
      Size            =   "2328;688"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin VB.Menu cfile 
      Caption         =   "&File"
      Begin VB.Menu csel 
         Caption         =   "Save  Expression List  "
         Shortcut        =   ^S
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu crel 
         Caption         =   "Solve Expression List"
         Shortcut        =   ^R
      End
      Begin VB.Menu sep0 
         Caption         =   "-"
      End
      Begin VB.Menu clel 
         Caption         =   "Load  Expression List"
         Shortcut        =   ^L
      End
      Begin VB.Menu sep9 
         Caption         =   "-"
      End
      Begin VB.Menu csmem 
         Caption         =   "Save  Memories"
         Shortcut        =   ^M
      End
      Begin VB.Menu sep10 
         Caption         =   "-"
      End
      Begin VB.Menu cexit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu cedit 
      Caption         =   " &Edit"
      Begin VB.Menu ccopye 
         Caption         =   "Copy Expression"
         Shortcut        =   ^C
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu ccopya 
         Caption         =   "Copy Answer"
         Shortcut        =   ^A
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu cpastee 
         Caption         =   "Paste Expression"
         Shortcut        =   ^P
      End
      Begin VB.Menu sep4 
         Caption         =   "-"
      End
      Begin VB.Menu cclearel 
         Caption         =   "Clear Expression List  "
         Shortcut        =   ^D
      End
      Begin VB.Menu sep7 
         Caption         =   "-"
      End
      Begin VB.Menu cclm 
         Caption         =   "Clear Memory"
         Shortcut        =   ^Y
      End
      Begin VB.Menu sep8 
         Caption         =   "-"
      End
      Begin VB.Menu ccmall 
         Caption         =   "Clear Memory All"
         Shortcut        =   ^E
      End
   End
   Begin VB.Menu chelp 
      Caption         =   " &Help"
      Begin VB.Menu chelptopic 
         Caption         =   "Help Topics "
         Shortcut        =   {F1}
      End
      Begin VB.Menu sep5 
         Caption         =   "-"
      End
      Begin VB.Menu cabout 
         Caption         =   "About"
         Shortcut        =   {F2}
      End
   End
End
Attribute VB_Name = "Scientific"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

'---Only use Uppercase letters for Memory
'---Only use Lowercase letters for Operators
'---Only use Lowercase letters for function
'---Never use mixture of lower & upper case letters

Option Explicit

Dim eraflg As Boolean
Dim mem As memory
Dim mq As MQueue


Private Sub cabout_Click()
    Call fabout.Show(vbModal, Me)
End Sub

Private Sub cansmem_Click(Indx As Integer)
Dim tmp As String
    
    texp.SetFocus
    
    If Indx = 0 Then
        tmp = MQgetPrev(mq)
        If Trim(tmp) <> "NULL" Then
            eraflg = False
            texp.Text = tmp
            Call SendKeys("{END}")
        Else
            cansmem(0).Enabled = False
        End If
        If mq.Front > -1 Then
            cansmem(1).Enabled = True
        End If
    ElseIf Indx = 1 Then
        tmp = MQgetNext(mq)
        If Trim(tmp) <> "NULL" Then
            eraflg = False
            texp.Text = tmp
            Call SendKeys("{END}")
        Else
            cansmem(1).Enabled = False
        End If
        If mq.Front > 0 Then
            cansmem(0).Enabled = True
        End If
    ElseIf Indx = 2 Then
        eraflg = False
        Call SendKeys("{END}")
    End If
End Sub



Private Sub cclearel_Click()
    If MsgBox("This will clear current expression list." + vbCrLf + vbCrLf + "Clear?", vbYesNo, "Clear Expression List?") = vbYes Then
        Call InitiateMQ(mq, 100)
        cansmem(0).Enabled = False
        cansmem(1).Enabled = False
    End If
End Sub

Private Sub cclm_Click()
    If MsgBox("This will clear Memory-M to 0." + vbCrLf + "Are you sure?", vbYesNo, "Memory Clear Confirm!") = vbYes Then
        mem.value(0) = "0"
    End If
End Sub

Private Sub ccmall_Click()
Dim i As Long
If MsgBox("This will clear all Memories  to 0." + vbCrLf + "Are you sure?", vbYesNo, "Memory Clear Confirm!") = vbYes Then
    For i = 0 To mem.cnt - 1
        mem.value(i) = "0"
    Next i
    tans = ""
End If
End Sub

Private Sub ccopya_Click()
    Call Clipboard.SetText(tans.Text)
End Sub

Private Sub ccopye_Click()
    Call Clipboard.SetText(texp.Text)
End Sub

Private Sub cedit_Click()
    If Trim(texp.Text) = "" Then
        ccopye.Enabled = False
    Else
        ccopye.Enabled = True
    End If
    If Trim(tans.Text) = "" Then
        ccopya.Enabled = False
    Else
        ccopya.Enabled = True
    End If
    If Trim(Clipboard.GetText(1)) = "" Then
        cpastee.Enabled = False
    Else
        cpastee.Enabled = True
    End If
    If mq.Front = -1 Then
        cclearel.Enabled = False
    Else
        cclearel.Enabled = True
    End If
End Sub

Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub cfile_Click()
    If mq.Front <> -1 Then
        csel.Enabled = True
    Else
        csel.Enabled = False
    End If
End Sub

Private Sub chyp_Click()
    If texp.Visible Then texp.SetFocus
End Sub

Private Sub chyp_KeyPress(Key As MSForms.ReturnInteger)
    eraflg = True
    Call texp_KeyPress(Key)
End Sub

Private Sub cinv_Click()
    If texp.Visible Then texp.SetFocus
End Sub

Private Sub cinv_KeyPress(Key As MSForms.ReturnInteger)
    eraflg = True
    Call texp_KeyPress(Key)
End Sub

Private Sub clel_Click()
On Error GoTo Cancel

    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H1000& Or &H800&
    dialog1.ShowOpen
    If Trim(dialog1.Filename) = "" Then
         GoTo Cancel
    End If
    If LoadExpressionList(dialog1.Filename, mq, mem) = False Then
        MsgBox "Error During Loading", vbOKOnly, "Loading Error!!!"
    End If
    Exit Sub

Cancel:
   
End Sub

Private Sub cm_Click(Indx As Integer)
On Error GoTo xit
Dim tmp As String
Dim valid As Boolean
Dim res As String

    If Indx = 0 Then
        res = ProcessExpression(texp, mem, valid)
        If valid Then
            mem.value(0) = Evaluate_Expression(LCase(mem.value(0) & "+" & res), fun, opr, preoptr, postoptr, valid, IIf(ordg(0).value = True, "rad", IIf(ordg(1).value = True, "deg", "grd")))
            eraflg = True
        End If
    ElseIf Indx = 1 Then
        res = ProcessExpression(texp, mem, valid)
        If valid Then
            mem.value(0) = Evaluate_Expression(LCase(mem.value(0) & "-" & res), fun, opr, preoptr, postoptr, valid, IIf(ordg(0).value = True, "rad", IIf(ordg(1).value = True, "deg", "grd")))
            eraflg = True
        End If
    ElseIf Indx = 2 Then
        texp.SetFocus
        Call SendKeysProper(mem.value(0))
    ElseIf Indx = 3 Then
        mem.value(0) = "0"
    ElseIf Indx = 4 Then
        texp.SetFocus
        Call SendKeysProper(mem.nam(0))
    End If
    Exit Sub
xit:
    MsgBox "Memory M, Error." + vbCrLf + Err.Description, vbOKOnly, "Error Detected!"
End Sub

Private Sub cm_KeyPress(Index As Integer, Key As MSForms.ReturnInteger)
    Call texp_KeyPress(Key)
End Sub

Private Sub cmem_Click(Indx As Integer)
Dim res As String
Dim valid As Boolean

    texp.SetFocus
    If omem(1).value = True Or omem(2).value = True Then
        Call SendKeysProper(IIf(omem(1).value = True, mem.value(Indx + 1), mem.nam(Indx + 1)))
    ElseIf omem(0).value = True Then
         eraflg = True
         res = CStr(ProcessExpression(texp, mem, valid))
         If valid Then
            mem.value(Indx + 1) = res
         End If
    End If
End Sub

Private Sub cmfun_Click(Index As Integer)
    texp.SetFocus
    Call SendKeysProper(cmfun.item(Index).Caption)
End Sub

Private Sub coperand_Click(Index As Integer)
    texp.SetFocus
    If Index < 15 Then
        Call SendKeys(IIf(Index = 10 Or Index = 13 Or Index = 14, "{", "") & coperand.item(Index).Caption & IIf(Index = 10 Or Index = 13 Or Index = 14, "}", ""))
    ElseIf Index = 15 Then
        texp = ""
        tans = ""
    End If
End Sub

Private Sub coptr_Click(Index As Integer)
Dim res As Variant
Dim succ As Boolean
Dim exp As String

    texp.SetFocus
    If Index <= 7 Then
        Call SendKeys(IIf(Index = 0 Or Index = 3 Or Index = 4, "{", "") & coptr.item(Index).Caption & IIf(Index = 0 Or Index = 3 Or Index = 4, "}", ""))
    ElseIf Index <= 9 Then
        Call SendKeys(IIf(Index = 8, "c", "p"))
    ElseIf Index = 11 Then
        If Len(texp) >= 1 Then
            Call SendKeys("{BKSP}")
        End If
    ElseIf Index = 12 Then
        Call SendKeysProper(coptr(Index).Caption)
    ElseIf Index = 10 Then
        eraflg = True
        Call ProcessExpression(texp, mem, succ)
    End If
End Sub


Private Function ProcessExpression(ByVal expr As String, mem As memory, valid As Boolean) As String
On Error GoTo xit
Dim exp As String
Dim res As Variant
Dim succ As Boolean
Dim i As Long
Dim store As String
Dim org As String
        
        
        org = expr
        i = FindStore(expr)
        If i > 0 Then
            store = Mid(expr, i + 2, Len(expr) - i - 1)
            expr = Left(expr, i - 1)
            If store = "" Then store = "UnKnown"
        Else
            store = ""
        End If
        exp = PreProcessor(expr, mem)
        res = Evaluate_Expression(LCase(exp), fun, opr, preoptr, postoptr, succ, IIf(ordg(0).value = True, "rad", IIf(ordg(1).value = True, "deg", "grd")))
        If succ Then
            tans = Trim(LCase(Str(res)))
            mem.value(mem.cnt - 1) = tans
            valid = True
            ProcessExpression = tans
            Call MQinsert(mq, org)
            If mq.Front >= 0 Then
                cansmem(0).Enabled = True
            Else
                cansmem(0).Enabled = False
            End If
            cansmem(1).Enabled = False
            If store <> "" Then
                For i = 0 To mem.cnt - 1 Step 1
                    If Trim(store) = Trim(mem.nam(i)) Then
                        mem.value(i) = tans
                        Exit For
                    End If
                Next i
                If i = mem.cnt Then
                    MsgBox "Invalid Memory Reference.", vbOKOnly, "UnMatched Memory!"
                End If
            End If
        Else
            tans = "Syntax Error"
            valid = False
            ProcessExpression = "NULL"
        End If
        Exit Function
xit:
    valid = False
    tans = Err.Description
    ProcessExpression = "NULL"
End Function

Private Sub cpastee_Click()
    texp.Text = Clipboard.GetText()
End Sub

Private Sub crel_Click()
On Error GoTo Cancel
Dim f1 As String
Dim f2 As String

    dialog1.DialogTitle = "Open File Containing Expression List"
    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H1000& Or &H800&
    dialog1.ShowOpen
    If Trim(dialog1.Filename) = "" Then
         GoTo Cancel
    End If
    f1 = dialog1.Filename
    dialog1.DialogTitle = "SaveFile For Answers"
    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800&
    dialog1.ShowOpen
    If Trim(dialog1.Filename) = "" Then
         GoTo Cancel
    End If
    f2 = dialog1.Filename
    If Trim(f1) = Trim(f2) Then
        MsgBox "Source & Destination Files should be different", vbOKOnly, "File Error"
        GoTo Cancel
    End If
    If ExecuteExpressionList(f1, f2, mq, mem) = False Then
        MsgBox "Error During Evaluation of Expressions", vbOKOnly, "Loading Error!!!"
    End If
    Exit Sub

Cancel:
End Sub

Private Sub csel_Click()
On Error GoTo Cancel

    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800&
    dialog1.ShowOpen
    If Trim(dialog1.Filename) = "" Then
        GoTo Cancel
    End If
    If SaveExpressionList(dialog1.Filename, mq) = False Then
        MsgBox "Error During Saving", vbOKOnly, "Save Error!!!"
    End If
    Exit Sub

Cancel:
   
End Sub

Private Sub csmem_Click()
On Error GoTo Cancel

    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800&
    dialog1.ShowOpen
    If Trim(dialog1.Filename) = "" Then
        GoTo Cancel
    End If
    If SaveMemories(dialog1.Filename, mem) = False Then
        MsgBox "Error During Saving", vbOKOnly, "Save Error!!!"
    End If
    Exit Sub

Cancel:
   
End Sub

Private Sub cspace_Click()
    texp.SetFocus
    Call SendKeysProper(" ")
End Sub

Private Sub ctrig_Click(Index As Integer)
    texp.SetFocus
    Call SendKeysProper(IIf(cinv.value = True, "a", "") & ctrig.item(Index).Caption & IIf(chyp.value = True, "h", ""))
End Sub

Private Sub Form_Load()
Dim i As Long

    
    
    Call Set_Operators(opr)
    Call Set_PostfixOperators(postoptr)
    Call Set_PrefixOperators(preoptr)
    Call Set_Functions(fun)
    
    Call InitiateMQ(mq, 100)
    
    eraflg = False
    cansmem(0).Enabled = False
    cansmem(1).Enabled = False
    ordg(0).value = True
    omem(1).value = True
    
    mem.cnt = 10
    ReDim mem.nam(mem.cnt) As String
    ReDim mem.value(mem.cnt) As String
    mem.nam(0) = "M"
    mem.value(0) = "0"
    For i = 1 To mem.cnt - 2 Step 1
        mem.nam(i) = Chr(i + 64)
        mem.value(i) = "0"
    Next i
    mem.nam(mem.cnt - 1) = "ANS"
    mem.value(mem.cnt - 1) = "0"
End Sub

Private Sub omem_Click(Index As Integer)
    If texp.Visible Then texp.SetFocus
End Sub

Private Sub omem_KeyPress(Index As Integer, Key As MSForms.ReturnInteger)
    eraflg = True
    Call texp_KeyPress(Key)
End Sub

Private Sub ordg_Click(Index As Integer)
    If texp.Visible Then texp.SetFocus
End Sub

Private Sub ordg_KeyPress(Index As Integer, Key As MSForms.ReturnInteger)
    Call texp_KeyPress(Key)
End Sub
 
Private Sub texp_KeyDown(Key As MSForms.ReturnInteger, Shift As Integer)
    If Key = 13 Then
        coptr_Click (10)
        texp.SetFocus
    ElseIf Key = 37 Or Key = 39 Then
        eraflg = False
    End If
End Sub

Private Sub texp_KeyPress(Key As MSForms.ReturnInteger)
    If eraflg = True Then
        texp = ""
        texp.SetFocus
    End If
    eraflg = False
    If Chr$(Key) = "=" Then
        Key = 0
        Call coptr_Click(10)
        Exit Sub
    End If
    
End Sub


Private Function SaveExpressionList(Filename As String, mq As MQueue) As Boolean
On Error GoTo xit
Dim Fso As New FileSystemObject
Dim txt As Object
Dim s As Long
Dim flg  As Boolean

    Set txt = Fso.OpenTextFile(Filename, ForAppending, True)
    s = (mq.Front + 1) Mod mq.Size
    flg = True
    While flg Or ((s Mod mq.Size) <> ((mq.Front + 1) Mod mq.Size))
        If mq.Xist(s) = True Then
            txt.WriteLine (mq.Aray(s))
        End If
        flg = False
        s = (s + 1) Mod mq.Size
    Wend
    txt.Close
    SaveExpressionList = True
    Exit Function
    
xit:
SaveExpressionList = False
End Function

Private Function SaveMemories(Filename As String, mem As memory) As Boolean
On Error GoTo xit
Dim Fso As New FileSystemObject
Dim txt As TextStream
Dim i As Long

    Set txt = Fso.OpenTextFile(Filename, ForAppending, True)
    For i = 0 To mem.cnt - 1 Step 1
        txt.WriteLine (mem.value(i) & "->" & mem.nam(i))
    Next i
    txt.Close
    SaveMemories = True
    Exit Function
    
xit:
SaveMemories = False
End Function

Private Function LoadExpressionList(Filename As String, mq As MQueue, mem As memory) As Boolean
On Error GoTo FileError
Dim NewLine As String
Dim acceptable As Boolean

    Open Filename For Input As #1
    Do Until EOF(1)
        Line Input #1, NewLine
        
        If Trim(NewLine) <> "" Then
            Call ProcessExpression(NewLine, mem, acceptable)
            If acceptable Then texp = NewLine
        End If
    Loop
    Close #1
    LoadExpressionList = True
    Exit Function

FileError:
    LoadExpressionList = False
End Function

Private Function ExecuteExpressionList(Filename As String, dstfilename As String, mq As MQueue, mem As memory) As Boolean
On Error GoTo FileError
Dim txt As TextStream
Dim Fso As New FileSystemObject
Dim NewLine As String
Dim acceptable As Boolean
Dim exp As String
Dim res As Variant
Dim ref As Long

    Open Filename For Input As #1
    Set txt = Fso.OpenTextFile(dstfilename, ForAppending, True)
loop1:
    Do Until EOF(1)
        On Error GoTo FileError
        Line Input #1, NewLine
        
        On Error GoTo prcs
        If Trim(NewLine) <> "" Then
            ref = StoreRef(NewLine, exp, mem)
            exp = PreProcessor(exp, mem)
            res = Evaluate_Expression(LCase(exp), fun, opr, preoptr, postoptr, acceptable, IIf(ordg(0).value = True, "rad", IIf(ordg(1).value = True, "deg", "grd")))
            txt.WriteLine (" ")
            If acceptable Then
                txt.WriteLine (NewLine & "=" & CStr(res))
                If ref <> -1 Then mem.value(ref) = CStr(res)
            Else
                txt.WriteLine (NewLine & ":Syntax Error")
            End If
        End If
        GoTo loop1
prcs:
        txt.WriteLine (NewLine & ":" & Err.Description)
    Loop
    Close #1
    txt.Close
    ExecuteExpressionList = True
    Exit Function

FileError:
    ExecuteExpressionList = False
End Function

Private Sub texp_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
     eraflg = False
End Sub

Private Sub SendKeysProper(s As String)
Dim i As Long
Dim tmp As String

    i = 1
    While i <= Len(s)
         tmp = Mid(s, i, 1)
         If tmp = "+" Or tmp = "%" Or tmp = "^" Then
            Call SendKeys("{" & tmp & "}")
        Else
            Call SendKeys(tmp)
        End If
        i = i + 1
    Wend
    
End Sub

