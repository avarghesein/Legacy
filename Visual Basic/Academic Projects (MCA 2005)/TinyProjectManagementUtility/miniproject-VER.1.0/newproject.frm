VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form newproject 
   Caption         =   "NEW PROJECT SCHEDULER"
   ClientHeight    =   5205
   ClientLeft      =   1650
   ClientTop       =   2220
   ClientWidth     =   8880
   Icon            =   "newproject.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5205
   ScaleWidth      =   8880
   Begin VB.CommandButton cselectid 
      Caption         =   "SELECT ID"
      Height          =   300
      Left            =   7643
      TabIndex        =   4
      Top             =   1935
      Width           =   975
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
      Height          =   330
      IMEMode         =   3  'DISABLE
      Left            =   4283
      MaxLength       =   30
      PasswordChar    =   "*"
      TabIndex        =   6
      Top             =   3735
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
      Left            =   4283
      MaxLength       =   30
      PasswordChar    =   "*"
      TabIndex        =   5
      Top             =   3375
      Width           =   3255
   End
   Begin MSMask.MaskEdBox mtxtdate 
      Height          =   375
      Left            =   4283
      TabIndex        =   2
      Top             =   1575
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   10
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Mask            =   "99/99/9999"
      PromptChar      =   "_"
   End
   Begin VB.CommandButton ccancel 
      Caption         =   "CANCEL"
      Height          =   375
      Left            =   5483
      TabIndex        =   7
      Top             =   4455
      Width           =   1095
   End
   Begin VB.CommandButton ok 
      Caption         =   "OK"
      Height          =   375
      Left            =   6683
      TabIndex        =   8
      Top             =   4455
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
      Height          =   330
      Left            =   4283
      Locked          =   -1  'True
      MaxLength       =   30
      TabIndex        =   3
      Top             =   1935
      Width           =   3255
   End
   Begin VB.TextBox txtdesc 
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   4283
      MaxLength       =   200
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   735
      Width           =   3255
   End
   Begin VB.TextBox txtname 
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
      Left            =   4283
      MaxLength       =   30
      TabIndex        =   0
      Top             =   375
      Width           =   3255
   End
   Begin VB.Label lman 
      Alignment       =   1  'Right Justify
      Caption         =   " "
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
      Left            =   803
      TabIndex        =   15
      Top             =   2535
      Width           =   3375
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
      Left            =   923
      TabIndex        =   14
      Top             =   3735
      Width           =   3255
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
      Left            =   923
      TabIndex        =   13
      Top             =   3375
      Width           =   3255
   End
   Begin VB.Label LABMAN 
      Alignment       =   1  'Right Justify
      Caption         =   "PROJECT MANAGER(PERSON  ID)"
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
      Left            =   923
      TabIndex        =   12
      Top             =   1935
      Width           =   3255
   End
   Begin VB.Label LABSTART 
      Alignment       =   1  'Right Justify
      Caption         =   "START DATE(MM/DD/YYYY)"
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
      Left            =   1043
      TabIndex        =   11
      Top             =   1575
      Width           =   3135
   End
   Begin VB.Label LABDESC 
      Alignment       =   1  'Right Justify
      Caption         =   "PROJECT DISCRIPTION"
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
      Left            =   1740
      TabIndex        =   10
      Top             =   1050
      Width           =   2445
   End
   Begin VB.Label LABNAME 
      Alignment       =   1  'Right Justify
      Caption         =   "NEW PROJECT NAME"
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
      Left            =   1770
      TabIndex        =   9
      Top             =   420
      Width           =   2385
   End
End
Attribute VB_Name = "newproject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim flg As Boolean

Private Sub ccancel_Click()
    Unload Me
End Sub


Private Sub cselectid_Click()
    flg = True
    txtman = ""
    Me.Hide
    personform.owner = "NEWPROJECT"
    personform.person_chois = "SELECT"
    personform.Show
End Sub

Private Sub Form_GotFocus()
   If flg = False Then
        txtname.SetFocus
   Else
        flg = False
   End If
End Sub

Private Sub Form_Load()
flg = False
Me.Left = (Screen.Width - Me.Width) / 2
Me.Top = (Screen.Height - Me.Height) / 2
End Sub

Private Sub Form_Unload(cancel As Integer)
introduction.initialize
adminform.Show
End Sub
Private Sub mtxtdate_KeyPress(pKey As Integer)
    If pKey = 13 Then
        If IsDate(mtxtdate) Then
            cselectid.SetFocus
        Else
            MsgBox "INCORRECT DATE", vbOKCancel, "ERROR IN DATE"
            mtxtdate.SetFocus
        End If
    Exit Sub
    
    End If
    pKey = pKey
    
End Sub


Private Sub ok_Click()

If Trim(txtname) <> "" And Val(txtman) <> 0 _
   And IsDate(mtxtdate.Text) And Len(pass) >= 10 And Len(pass) <= 30 _
   And passconfirm = pass Then
   
   glob_proj.pwd = passconfirm
   glob_proj.pnam = txtname
   glob_proj.pdesc = txtdesc
   glob_proj.pmanager = Val(txtman)
   glob_proj.pstart = DateValue(Format$(mtxtdate, "mm/dd/yyyy"))
   txtname = ""
   txtdesc = ""
   txtman = ""
   pass = ""
   passconfirm = ""
   mtxtdate.Text = "99/99/9999"
   Me.Hide
   tasksform.owner_admin = False
   tasksform.Show
Else
   MsgBox "INCORRECT VALUES", vbYesNo + vbCritical, "ERROR IN VALUES"
End If

    
End Sub


Private Sub pass_KeyPress(pKey As Integer)

If pKey = 13 Then
    If Len(pass) < 10 Or Len(pass) > 30 Then
       MsgBox "PASSWORD MUST CONSIST ATLEAST 10 AND ATMOST 30 CHARACTERS", vbOKOnly, "PASSWORD ERROR"
       Exit Sub
    Else
       passconfirm.SetFocus
    End If
Else
      If pKey = vbKeyBack Then
         pKey = vbKeyBack
      End If
End If
Exit Sub
End Sub

Private Sub passconfirm_KeyPress(pKey As Integer)

If pKey = 13 Then
    If Len(pass) < 10 Or Len(pass) > 30 Then
       MsgBox "PASSWORD MUST CONSIST ATLEAST 10 AND ATMOST 30 CHARACTERS", vbOKOnly, "PASSWORD ERROR!!!"
    Else
       If passconfirm <> pass Then
          MsgBox "PASSWORDS MISMATCHED,RE-ENTER IT", vbOKOnly, "PASSWORD ERROR!!!"
       Else
          Call ok_Click
       End If
    End If
Else
      If pKey = vbKeyBack Then
         pKey = vbKeyBack
      End If
End If

Exit Sub
End Sub

Private Sub txtdesc_KeyPress(pKey As Integer)

If pKey = vbKeyBack Then pKey = vbKeyBack

End Sub

Private Sub txtname_KeyPress(pKey As Integer)

If pKey = 13 Then
    If Trim(txtname) <> "" Then
        txtdesc.SetFocus
     Else
        MsgBox "INVALID PROJECT NAME", vbOKCancel, "PROJECT NAME ERROR"
        txtname.SetFocus
     End If
     
     Exit Sub
End If

If pKey = vbKeyBack Then Exit Sub

End Sub

