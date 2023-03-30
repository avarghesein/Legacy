VERSION 5.00
Begin VB.Form adminform 
   Caption         =   "ADMINISTRATOR OPTIONS"
   ClientHeight    =   5520
   ClientLeft      =   1650
   ClientTop       =   2025
   ClientWidth     =   8880
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Admin.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5520
   ScaleWidth      =   8880
   Begin VB.Timer Timer1 
      Interval        =   100
      Left            =   210
      Top             =   3570
   End
   Begin VB.Frame fchangepass 
      Caption         =   "ENTER MANAGER NAME && OLD PASSWORD"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1155
      Left            =   1793
      TabIndex        =   0
      Top             =   360
      Width           =   5295
      Begin VB.CommandButton coldcancel 
         Caption         =   "CANCEL"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   4140
         TabIndex        =   4
         Top             =   690
         Width           =   1065
      End
      Begin VB.CommandButton cold 
         Caption         =   "OK"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   4140
         TabIndex        =   3
         Top             =   270
         Width           =   1065
      End
      Begin VB.TextBox toldpass 
         Height          =   315
         Left            =   90
         MaxLength       =   30
         TabIndex        =   2
         Top             =   690
         Width           =   3975
      End
      Begin VB.TextBox toldname 
         Height          =   375
         Left            =   90
         MaxLength       =   30
         TabIndex        =   1
         Top             =   270
         Width           =   3975
      End
   End
   Begin Project_Sheduler.datecalculatordemo2 datecalculator1 
      Height          =   4095
      Left            =   2205
      TabIndex        =   15
      Top             =   540
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   7223
      typeofoperand1  =   0   'False
   End
   Begin VB.Frame fprojectselect 
      Caption         =   "PROJECT-SELECTION"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Left            =   1493
      TabIndex        =   11
      Top             =   1710
      Width           =   5895
      Begin VB.CommandButton cprojectselect 
         Caption         =   "OK"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2280
         TabIndex        =   14
         Top             =   1200
         Width           =   1335
      End
      Begin VB.ComboBox projnamecombo 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   240
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   720
         Width           =   2655
      End
      Begin VB.ComboBox projidcombo 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         ItemData        =   "Admin.frx":030A
         Left            =   3000
         List            =   "Admin.frx":030C
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   720
         Width           =   2655
      End
      Begin VB.Label Label3 
         Caption         =   "SELECT PROJECT NAME"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   510
         TabIndex        =   21
         Top             =   360
         Width           =   2145
      End
      Begin VB.Label l1 
         Caption         =   "SELECT PROJECT"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   600
         TabIndex        =   16
         Top             =   750
         Width           =   1695
      End
      Begin VB.Label l2 
         Caption         =   "SELECT PROJECT ID"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   3450
         TabIndex        =   20
         Top             =   360
         Width           =   1695
      End
   End
   Begin VB.Frame fadminpass 
      Caption         =   "SET ADMINISTRATOR AND PASSWORD"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   1133
      TabIndex        =   5
      Top             =   1650
      Visible         =   0   'False
      Width           =   6615
      Begin VB.CommandButton admincancel 
         Caption         =   "CANCEL"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   5430
         TabIndex        =   10
         Top             =   1440
         Width           =   1095
      End
      Begin VB.CommandButton adminsave 
         Caption         =   "SAVE"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   4080
         TabIndex        =   9
         Top             =   1440
         Width           =   1095
      End
      Begin VB.TextBox txtman 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   3240
         MaxLength       =   45
         TabIndex        =   6
         Top             =   360
         Width           =   3255
      End
      Begin VB.TextBox pass 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         IMEMode         =   3  'DISABLE
         Left            =   3240
         MaxLength       =   30
         PasswordChar    =   "*"
         TabIndex        =   7
         Top             =   720
         Width           =   3255
      End
      Begin VB.TextBox passconfirm 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         IMEMode         =   3  'DISABLE
         Left            =   3240
         MaxLength       =   30
         PasswordChar    =   "*"
         TabIndex        =   8
         Top             =   1080
         Width           =   3255
      End
      Begin VB.Label LABMAN 
         Alignment       =   1  'Right Justify
         Caption         =   "ADMIN'S NAME"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   630
         TabIndex        =   19
         Top             =   390
         Width           =   2535
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "PASSWORD THAT YOU LIKE TO LOGIN"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   720
         Width           =   2895
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         Caption         =   "CONFIRM PASSWORD"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1320
         TabIndex        =   17
         Top             =   1080
         Width           =   1815
      End
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "C"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   8
      Left            =   4440
      TabIndex        =   37
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   15
      Left            =   7800
      TabIndex        =   36
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "E"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   14
      Left            =   7320
      TabIndex        =   35
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "L"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   13
      Left            =   6840
      TabIndex        =   34
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "U"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   12
      Left            =   6360
      TabIndex        =   33
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "D"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   11
      Left            =   5880
      TabIndex        =   32
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "E"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   10
      Left            =   5400
      TabIndex        =   31
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "H"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   9
      Left            =   4920
      TabIndex        =   30
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "S"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   7
      Left            =   3960
      TabIndex        =   29
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "T"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   6
      Left            =   3480
      TabIndex        =   28
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "C"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   5
      Left            =   3000
      TabIndex        =   27
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "E"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   4
      Left            =   2520
      TabIndex        =   26
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "J"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   3
      Left            =   2040
      TabIndex        =   25
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "O"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   2
      Left            =   1560
      TabIndex        =   24
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   1
      Left            =   1080
      TabIndex        =   23
      Top             =   4920
      Width           =   375
   End
   Begin VB.Label rmove 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "P"
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   14.25
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Index           =   0
      Left            =   600
      TabIndex        =   22
      Top             =   4920
      Width           =   375
   End
   Begin VB.Menu project 
      Caption         =   "PROJECT"
      Begin VB.Menu new 
         Caption         =   "NEW-SCHEDULE"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu edit 
         Caption         =   "EDIT-SCHEDULE"
         Begin VB.Menu descreedit 
            Caption         =   "PROJECT/TASK-REEDIT-DESCRIPTION"
         End
         Begin VB.Menu sepn 
            Caption         =   "-"
         End
         Begin VB.Menu changemans 
            Caption         =   "CHANGEMANAGERS"
         End
         Begin VB.Menu sep0 
            Caption         =   "-"
         End
         Begin VB.Menu projedit 
            Caption         =   "PROJECT-STARTDATE-REEDIT"
         End
         Begin VB.Menu sep2 
            Caption         =   "-"
         End
         Begin VB.Menu taskedit 
            Caption         =   "TASK-DURATION-REEDIT"
         End
         Begin VB.Menu sep3 
            Caption         =   "-"
         End
         Begin VB.Menu addnewtask 
            Caption         =   "ADD-NEW TASK"
         End
         Begin VB.Menu sepx 
            Caption         =   "-"
         End
         Begin VB.Menu reincomptasks 
            Caption         =   "RESCHEDULE-NONSTARTED-TASKS"
         End
         Begin VB.Menu seper 
            Caption         =   "-"
         End
         Begin VB.Menu reschedulemain 
            Caption         =   "RESCHEDULE-ENTIRE-PROJECT"
         End
      End
      Begin VB.Menu view 
         Caption         =   "VIEW"
         Begin VB.Menu viewshedule 
            Caption         =   "PROJECT/UPDATE"
         End
         Begin VB.Menu sep4 
            Caption         =   "-"
         End
         Begin VB.Menu specialview 
            Caption         =   "SPECIAL-VIEW"
         End
      End
      Begin VB.Menu sep5 
         Caption         =   "-"
      End
      Begin VB.Menu delshedule 
         Caption         =   "DELETE-SCHEDULE"
      End
      Begin VB.Menu sep6 
         Caption         =   "-"
      End
      Begin VB.Menu recallproject 
         Caption         =   "RECALL-SCHEDULE"
      End
      Begin VB.Menu sepp 
         Caption         =   "-"
      End
      Begin VB.Menu viewall 
         Caption         =   "VIEW-ALL-PROJECTS"
      End
      Begin VB.Menu sepnn 
         Caption         =   "-"
      End
      Begin VB.Menu exitadmin 
         Caption         =   "EXIT-ADMIN"
      End
   End
   Begin VB.Menu admintools 
      Caption         =   "ADMIN-TOOLS"
      Begin VB.Menu newadmin 
         Caption         =   "NEW-ADMIN"
      End
      Begin VB.Menu sep7 
         Caption         =   "-"
      End
      Begin VB.Menu changepass 
         Caption         =   "CHANGE-PASSWORD"
      End
      Begin VB.Menu sep34 
         Caption         =   "-"
      End
      Begin VB.Menu datecalc 
         Caption         =   "DATE-CALCULATOR-DEMO"
      End
   End
   Begin VB.Menu personnel 
      Caption         =   "PERSONNEL"
      Begin VB.Menu addperson 
         Caption         =   "ADD-NEW-PERSON"
      End
      Begin VB.Menu sep8 
         Caption         =   "-"
      End
      Begin VB.Menu editperson 
         Caption         =   "EDIT-EXSISTING-PERSON"
      End
      Begin VB.Menu sep9 
         Caption         =   "-"
      End
      Begin VB.Menu viewperson 
         Caption         =   "VIEW-PERSON"
         Begin VB.Menu viewpersonexsist 
            Caption         =   "EXSISTING"
         End
         Begin VB.Menu sep10 
            Caption         =   "-"
         End
         Begin VB.Menu viewpersonnonexsist 
            Caption         =   "NON-EXSISTING"
         End
      End
      Begin VB.Menu sep11 
         Caption         =   "-"
      End
      Begin VB.Menu personnelregistry 
         Caption         =   "PERSONNEL-REGISTRY"
      End
      Begin VB.Menu sep12 
         Caption         =   "-"
      End
      Begin VB.Menu delperson 
         Caption         =   "DELETE-PERSON"
      End
   End
End
Attribute VB_Name = "adminform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim cnn As New Connection
Dim admin_chois As String
Dim chnge_pass As Boolean
Dim toright(16) As Boolean
Dim initials(16) As String

Private Sub addperson_Click()
    personform.person_chois = "NEW"
    Me.Hide
    personform.Show
End Sub

Private Sub admincancel_Click()
 Call enable_all(False)
 fadminpass.Visible = False
End Sub

Private Sub adminsave_Click()
  If Trim(txtman) <> "" And Len(Trim(pass)) >= 10 And Len(Trim(pass)) <= 30 And pass = passconfirm Then
      If savenewadmin(txtman, pass, chnge_pass) Then
        If chnge_pass = False Then
            MsgBox "ENTRY SUCCESS", vbOKOnly, "SAVED NEW ADMINISRTATOR"
        Else
            MsgBox "ENTRY SUCCESS", vbOKOnly, "YOUR PASSWORD CHANGED SUCCESSFULLY!!!"
        End If
        Call enable_all(False)
      End If
  Else
    MsgBox "ERROR IN ENTERED DETAILS(NOTE:PASSWORS MUST CONTAIN ATLEAST 10 AND ATMOST 30 CHARACTERS)", vbCritical, "ERROR IN DETAILS!!!"
  End If
End Sub

Private Sub changemans_Click()
    Me.Hide
    changemanagerform.Show
End Sub

Private Sub changepass_Click()
   Call enable_all(False)
   fchangepass.Visible = True
   toldname.Enabled = True
   toldpass.Enabled = True
   toldname.SetFocus
   chnge_pass = True
End Sub

Private Sub cold_Click()
    If valid_admin(toldname, toldpass) Then
        Call enable_all(False)
        fadminpass.Visible = True
        txtman.Enabled = False
        pass.Enabled = True
        pass.SetFocus
        passconfirm.Enabled = True
    Else
        MsgBox "INVALID ADMIN ID", vbCritical, "UNAUTHORIZED ACCESS"
    End If
    
End Sub

Private Sub coldcancel_Click()
  enable_all (False)
End Sub

Private Sub cprojectselect_Click()
On Error GoTo cancel

    Select Case admin_chois
     
     Case "RE-SOME":
                    tasksform.owner_admin = True
                    tasksform.admin_change_all = False
                    glob_proj.pid = Val(projidcombo.Text)
                    glob_proj.pnam = projnamecombo.Text
                    Me.Hide
                    tasksform.Show
                    
     Case "RE-ALL":
                    tasksform.owner_admin = True
                    tasksform.admin_change_all = True
                    glob_proj.pid = Val(projidcombo.Text)
                    glob_proj.pnam = projnamecombo.Text
                    Me.Hide
                    tasksform.Show
     
     Case "VIEWNORMAL":
                    exsisting.exsist_owner = "ADMIN"
                    glob_proj.pid = Val(projidcombo.Text)
                    glob_proj.pnam = projnamecombo.Text
                    Me.Hide
                    exsisting.Show
                   
    
     Case "DELETE":
                    If MsgBox("ARE YOU SURE TO DELETE?", vbYesNo, "CONFIRM DELETE") = vbYes Then
                    If cnn.State = 0 Then cnn.Open
                        cnn.BeginTrans
                        cnn.Execute ("update projects set deleted='T' where projid=" & Val(projidcombo.Text) & "")
                        cnn.CommitTrans
                    End If

     Case "RECALLPROJECT":
                    If cnn.State = 0 Then cnn.Open
                        cnn.BeginTrans
                        cnn.Execute ("update projects set deleted='F' where projid=" & Val(projidcombo.Text) & "")
                        cnn.CommitTrans
                    
    End Select

enable_all (False)
admin_chois = ""
Exit Sub

cancel:
    MsgBox Err.Description
    If cnn.State = 1 Then cnn.RollbackTrans
    enable_all (False)
    admin_chois = ""
End Sub

Private Sub datecalc_Click()
    enable_all (False)
    datecalculator1.Visible = True
End Sub


Private Sub delperson_Click()
    personform.person_chois = "DELETE"
    Me.Hide
    personform.Show
End Sub


Private Sub descreedit_Click()
    Me.Hide
    descform.Show
End Sub

Private Sub Form_Load()

Dim I As Integer

initials(0) = "P"
initials(1) = "R"
initials(2) = "O"
initials(3) = "J"
initials(4) = "E"
initials(5) = "C"
initials(6) = "T"
initials(7) = "S"
initials(8) = "C"
initials(9) = "H"
initials(10) = "E"
initials(11) = "D"
initials(12) = "U"
initials(13) = "L"
initials(14) = "E"
initials(15) = "R"

For I = 0 To 15
    rmove(I).Left = 600 + 480 * I
    rmove(I).Top = 4920
    rmove(I).Width = 375
    rmove(I).Height = 375
    rmove(I).Caption = initials(I)
    toright(I) = False
    rmove(I).Enabled = False
Next I


   Call enable_all(False)
   Set cnn = dn.cn

End Sub

Private Sub Form_Resize()
    Call Form_Load
End Sub

Private Sub personnelregistry_Click()
    Me.Hide
    register.reg_chois = "ADMIN"
    register.Show
End Sub

Private Sub projedit_Click()
 resheduleform.chois = "PSC"
 Me.Hide
 resheduleform.Show
End Sub

Private Sub recallproject_Click()
    enable_all (False)
    admin_chois = "RECALLPROJECT"
    Call STEP1
End Sub

Private Sub reincomptasks_Click()
    enable_all (False)
    admin_chois = "RE-SOME"
    Call STEP1
End Sub

Private Sub reschedulemain_Click()
    enable_all (False)
    admin_chois = "RE-ALL"
    Call STEP1
End Sub

Private Sub specialview_Click()
    Me.Hide
    specialproject.Show
End Sub
Private Sub addnewtask_Click()
resheduleform.chois = "NTE"
Me.Hide
resheduleform.Show
End Sub
Private Sub taskedit_Click()
 resheduleform.chois = "TSC"
 Me.Hide
 resheduleform.Show
End Sub

Private Sub Timer1_Timer()
    Dim I As Integer
    Dim j As Integer
    Dim tmp As Double
    Dim stg As String
    
    For I = 0 To 15 Step 1
        If toright(I) = False Then
            tmp = rmove(I).Left - 20
            If tmp <= 20 Then
                toright(I) = True
                rmove(I).Left = 20
            Else
                rmove(I).Left = tmp
            End If
         Else
            tmp = rmove(I).Left + 20
            If tmp >= (Me.ScaleWidth - 300) Then
                toright(I) = False
                rmove(I).Left = (Me.ScaleWidth - 300)
            Else
                rmove(I).Left = tmp
            End If
         End If
    
         For j = 0 To 15 Step 1
            If I <> j And rmove(I).Left = rmove(j).Left Then
                stg = rmove(I).Caption
                rmove(I).Caption = rmove(j).Caption
                rmove(j).Caption = stg
                Exit For
            End If
         Next j
    Next I
End Sub

Private Sub viewall_Click()
reporterform.hlp = False
reporterform.Show vbModal, Me
End Sub

Private Sub viewshedule_Click()
    enable_all (False)
    Call STEP1
    admin_chois = "VIEWNORMAL"
End Sub

Private Sub delshedule_Click()
    enable_all (False)
    Call STEP1
    admin_chois = "DELETE"
End Sub

Private Sub editperson_Click()
    personform.person_chois = "EDIT"
    Me.Hide
    personform.Show
End Sub

Private Sub exitadmin_Click()
 Unload Me
End Sub

Private Sub Form_Unload(cancel As Integer)
    Call introduction.initialize
    introduction.Show
End Sub

Private Sub new_Click()
    Me.Hide
    newproject.Show
End Sub

Private Sub newadmin_Click()
    enable_all (False)
    fadminpass.Visible = True
    pass.Enabled = True
    passconfirm.Enabled = True
    txtman.Enabled = True
    txtman.SetFocus
 End Sub

Private Sub pass_KeyPress(pKey As Integer)
    If check_passtextbox(pass, pKey, passconfirm) = False Then
      MsgBox "PASSWORD MUST CONSISTS ATLEAST 10 & ATMOST 30 CHARACTERS", vbCritical, "INVALID PASSWORD!!!"
    End If
End Sub

Private Sub passconfirm_KeyPress(pKey As Integer)
    If check_passtextbox(passconfirm, pKey, passconfirm) = False Then
      MsgBox "PASSWORD MUST CONSISTS ATLEAST 10 & ATMOST 30 CHARACTERS", vbCritical, "INVALID PASSWORD!!!"
    End If
End Sub



Private Sub toldname_KeyPress(pKey As Integer)
 If personform.check_textbox(Me.toldname, pKey, False, Me.toldpass) = False Then
    MsgBox "INVALID ADMINISTRATOR NAME", vbCritical, "INVALID NAME!!!"
 End If
End Sub


Private Sub toldpass_KeyPress(pKey As Integer)
   If check_passtextbox(toldpass, pKey, toldpass) = False Then
      MsgBox "PASSWORD MUST CONSISTS ATLEAST 10 & ATMOST 30 CHARACTERS", vbCritical, "INVALID PASSWORD!!!"
   End If
End Sub

Private Sub txtman_KeyPress(pKey As Integer)
 If personform.check_textbox(Me.txtman, pKey, False, Me.pass) = False Then
    MsgBox "INVALID ADMINISTRATOR NAME", vbCritical, "INVALID NAME!!!"
 End If
End Sub

Private Sub viewpersonexsist_Click()
    personform.person_chois = "VIEWX"
    Me.Hide
    personform.Show
End Sub

Private Sub viewpersonnonexsist_Click()
    personform.person_chois = "VIEWNX"
    Me.Hide
    personform.Show
End Sub

Public Function check_passtextbox(txtbox As TextBox, pKey As Integer, nextcntrl As Control) As Boolean
 
  check_passtextbox = True
  If pKey = 13 Then
        If Len(Trim(txtbox)) >= 10 Then
              nextcntrl.SetFocus
        Else
            check_passtextbox = False
            txtbox.SetFocus
        End If
  pKey = 0
  Else
      If pKey = vbKeyBack Then
         pKey = vbKeyBack
      End If
  End If

End Function

Private Sub enable_all(flg As Boolean)
    fchangepass.Visible = flg
    fadminpass.Visible = flg
    If chnge_pass = False Then
        txtman = ""
    Else
        txtman = toldname
    End If
    toldname = ""
    toldpass = ""
    pass = ""
    passconfirm = ""
    fprojectselect.Visible = flg
    projnamecombo.clear
    projnamecombo.Enabled = flg
    projidcombo.clear
    projidcombo.Enabled = flg
    cprojectselect.Enabled = flg
    datecalculator1.Visible = flg
End Sub

Private Sub freshprojnames()

Dim rs As New Recordset

If cnn.State = adStateClosed Then cnn.Open
If admin_chois = "RE-SOME" Then
    rs.Open "select distinct(projname) as projname from projects where (deleted='F' and projid in(select distinct(projid) from projectinprogress " & _
    "where startdate is null))", cnn
Else
    If admin_chois = "RE-ALL" Then
        rs.Open "select distinct(projname) as projname from projects where (deleted='F' and projid not in(select distinct(projid) from projectinprogress " & _
        "where startdate is not null) and projid not in(select distinct(projid) from register))", cnn
    Else
            If admin_chois <> "RECALLPROJECT" Then
                rs.Open "select distinct(projname) as projname from projects where deleted='F'", cnn
            Else
                rs.Open "select distinct(projname) as projname from projects where deleted='T'", cnn
            End If
    End If
End If

If rs.RecordCount <= 0 Then
  Call enable_all(False)
  Exit Sub
End If

Call addtocombobox(projnamecombo, rs, "projname")

End Sub

Private Sub projnamecombo_Click()
Dim rs As New Recordset
If projnamecombo.ListCount > 0 And projnamecombo.ListIndex <> -1 Then
     If cnn.State = adStateClosed Then cnn.Open

If admin_chois = "RE-SOME" Then
    rs.Open "select projid from projects where(deleted='F' and projid in(select distinct(projid) from projectinprogress " & _
    "where startdate is null) and projname='" & projnamecombo.Text & "')", cnn
Else
     If admin_chois = "RE-ALL" Then
        rs.Open "select projid from projects where (projname='" & projnamecombo.Text & "' and deleted='F' and projid not in(select distinct(projid) from projectinprogress " & _
        "where startdate is not null) and projid not in(select distinct(projid) from register))", cnn
     Else
            If admin_chois <> "RECALLPROJECT" Then
               rs.Open "select projid from projects where (projname='" & projnamecombo.Text & "' and deleted='F')", cnn
            Else
               rs.Open "select projid from projects where (projname='" & projnamecombo.Text & "' and deleted='T')", cnn
            End If
     End If
End If
     
     Call addtocombobox(projidcombo, rs, "projid")
     Call togglecombos(projidcombo, projnamecombo, False)
End If

End Sub

Private Sub projidcombo_Click()
 If projidcombo.ListCount <= 0 Or projidcombo.ListIndex = -1 Then Exit Sub
 cprojectselect.Enabled = True
End Sub


Public Sub STEP1()
    fprojectselect.Visible = True
    Call freshprojnames
    projnamecombo.Enabled = True
End Sub
