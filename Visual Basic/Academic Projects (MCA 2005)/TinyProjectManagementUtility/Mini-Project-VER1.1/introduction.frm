VERSION 5.00
Begin VB.Form introduction 
   AutoRedraw      =   -1  'True
   Caption         =   "PROJECT SCHEDULER             "
   ClientHeight    =   3240
   ClientLeft      =   2580
   ClientTop       =   3360
   ClientWidth     =   7110
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "introduction.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   216
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   474
   Begin VB.Frame fprojectid 
      Caption         =   "SELECT PROJECT ID"
      Height          =   735
      Left            =   3728
      TabIndex        =   7
      Top             =   413
      Width           =   2895
      Begin VB.ComboBox projidcombo 
         Height          =   375
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.Frame fprojectname 
      Caption         =   "SELECT PROJECT NAME"
      Height          =   735
      Left            =   488
      TabIndex        =   5
      Top             =   413
      Width           =   2895
      Begin VB.ComboBox projnamecombo 
         Height          =   375
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.CommandButton ok 
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
      Left            =   5408
      TabIndex        =   4
      Top             =   1853
      Width           =   855
   End
   Begin VB.Frame fpass 
      Caption         =   "PASSWORD"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   1688
      TabIndex        =   2
      Top             =   2093
      Width           =   3615
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
         Height          =   420
         IMEMode         =   3  'DISABLE
         Left            =   120
         MaxLength       =   30
         PasswordChar    =   "*"
         TabIndex        =   3
         Top             =   240
         Width           =   3375
      End
   End
   Begin VB.Frame fusername 
      Caption         =   "PERSON ID"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   1688
      TabIndex        =   0
      Top             =   1253
      Width           =   3615
      Begin VB.TextBox username 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   150
         MaxLength       =   30
         TabIndex        =   1
         Top             =   240
         Width           =   3375
      End
   End
   Begin VB.Menu project 
      Caption         =   "PROJECT-MANAGER"
      Begin VB.Menu view 
         Caption         =   "EXPLORE-PROJECT"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu exoloreregisterbyman 
         Caption         =   "EXPLORE-PERSONNEL-REGISTRY"
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu exit 
         Caption         =   "EXIT SCHEDULER"
      End
   End
   Begin VB.Menu registry 
      Caption         =   "PERSONNEL-REGISTER!"
   End
   Begin VB.Menu admintools 
      Caption         =   "ADMINISTRATOR"
      Begin VB.Menu admin 
         Caption         =   "LOGIN-AS-ADMIN"
      End
      Begin VB.Menu sepx 
         Caption         =   "-"
      End
      Begin VB.Menu regcancel 
         Caption         =   "CANCEL-REGISTRATION"
      End
   End
   Begin VB.Menu phelp 
      Caption         =   "HELP"
      Begin VB.Menu phelptopic 
         Caption         =   "HELP-TOPIC"
      End
      Begin VB.Menu sepy 
         Caption         =   "-"
      End
      Begin VB.Menu abouts 
         Caption         =   "ABOUT-SCHEDULER"
      End
   End
End
Attribute VB_Name = "introduction"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim chois As String
Dim cnn As New Connection

Private Sub abouts_Click()
    aboutshedule.Show vbModal, Me
End Sub

Private Sub admin_Click()
 chois = "ADMIN"
 Call disableallexceptnew
 ok.Enabled = True
 fusername.Caption = "ADMINISTRATOR NAME"
 fusername.Enabled = True
 fpass.Enabled = True
 username.SetFocus

End Sub

Private Sub Command1_Click()
Call deleteall
End Sub

Private Sub exit_Click()
 Unload Me
End Sub

Private Sub exoloreregisterbyman_Click()
 Call initialize
 chois = "REGISTERMAN"
 Call togglecombos(projnamecombo, projidcombo, True)
End Sub

Private Sub Form_Load()
Set cnn = dn.cn
Call initialize
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

 If Button = vbRightButton Then
    PopupMenu project
 End If
 
End Sub

Private Sub Form_Unload(cancel As Integer)
    cancel = 0
End Sub

Private Sub ok_Click()

Select Case chois
        
    Case "VIEW":
             If validuser(Val(projidcombo), Val(username), pass) Then
                  glob_proj.pnam = projnamecombo
                  glob_proj.pid = Val(projidcombo)
                  Call initialize
                  Me.Hide
                  exsisting.Show
             Else
                    MsgBox "INVALID MANAGER ID", vbCritical, "ACCESS DENIED"
                    
              End If
    Case "ADMIN":
              If valid_admin(username, pass) Then
                    adminform.Show
                    Me.Hide
              Else
                    MsgBox "INVALID ADMIN ID", vbCritical, "ACCESS DENIED"
              End If
              
    
    Case "REGDEL":
              If valid_admin(username, pass) Then
                    If MsgBox("You Are Going To Remove The Registration Of The Software." & vbCrLf & _
                    "You Must Set The DataBase Connection For Reusing It Again." & vbCrLf & _
                    "Your Administrator Power May Be Lost" & vbCrLf & _
                    "Are You Sure To Continue?", vbYesNo, "CAUTION!!![REGISTRATION GOING TO BE REMOVED]") = vbYes Then
              
                      Call del_registry
                      Unload Me
                      Exit Sub
                    End If
              Else
                    MsgBox "INVALID ADMIN ID", vbCritical, "ACCESS DENIED"
              End If
    
    Case "REGISTER":
                If isexsist("person", "id", Val(username)) Then
                    register.reg_chois = "PERSON"
                    register.reg_id = Val(username)
                    Me.Hide
                    register.Show
                Else
                    MsgBox "INVALID USER-ID", vbCritical, "ACCESS DENIED"
                End If
                
    
    Case "REGISTERMAN":
            If validuser(Val(projidcombo), Val(username), pass) Then
                    register.reg_chois = "MANAGER"
                    register.reg_id = Val(projidcombo)
                    Me.Hide
                    register.Show
             Else
                    MsgBox "INVALID MANAGER ID", vbCritical, "ACCESS DENIED"
             End If
    Case Else:
             MsgBox "error"
End Select

Call initialize
End Sub


Private Sub pass_KeyPress(pKey As Integer)
If pKey = 13 Then
    Call ok_Click
Else
      If pKey = vbKeyBack Then
         pKey = vbKeyBack
      End If
End If
Exit Sub
End Sub

Private Sub phelptopic_Click()
   reporterform.hlp = True
   reporterform.Show vbModal, Me
End Sub

Private Sub projidcombo_Click()
    
If projidcombo.ListCount <= 0 Or projidcombo.ListIndex = -1 Then Exit Sub

fusername.Enabled = True
fpass.Enabled = True
ok.Enabled = True
username.SetFocus

End Sub

Private Sub projnamecombo_Click()
Dim rs As New Recordset
If projnamecombo.ListCount > 0 And projnamecombo.ListIndex <> -1 Then
     If cnn.State = adStateClosed Then cnn.Open
     rs.Open "select projid from projects where (projname='" & projnamecombo.Text & "' and deleted='F')", cnn
     Call addtocombobox(projidcombo, rs, "projid")
     Call togglecombos(projidcombo, projnamecombo, False)
End If

End Sub

Private Sub regcancel_Click()
    Call admin_Click
    chois = "REGDEL"
End Sub

Private Sub registry_Click()
 chois = "REGISTER"
 Call disableallexceptnew
 ok.Enabled = True
 fusername.Enabled = True
 username.SetFocus
End Sub

Private Sub username_KeyPress(pKey As Integer)
  
  If pKey = 13 Then
      If chois = "REGISTER" Then
            Call ok_Click
      Else
           pass.SetFocus
      End If
  Else
      If pKey = vbKeyBack Then
         pKey = vbKeyBack
      End If
  End If
  Exit Sub
End Sub

Private Sub view_Click()
Call initialize
Call togglecombos(projnamecombo, projidcombo, True)
chois = "VIEW"
End Sub



Private Sub freshprojnames()

Dim rs As New Recordset

If cnn.State = adStateClosed Then cnn.Open
rs.Open "select distinct(projname) as projname from projects where deleted='F'", cnn

If rs.RecordCount <= 0 Then
  view.Enabled = False
  exoloreregisterbyman.Enabled = False
  Call disableallexceptnew
  Exit Sub
End If
exoloreregisterbyman.Enabled = True
view.Enabled = True
Call addtocombobox(projnamecombo, rs, "projname")
End Sub

Private Sub disableallexceptnew()
 pass = ""
 username = ""
 fusername.Enabled = False
 fusername.Caption = "USER ID"
 fpass.Enabled = False
 ok.Enabled = False
 projnamecombo.clear
 projidcombo.clear
 projnamecombo.Enabled = False
 projidcombo.Enabled = False
End Sub

Public Sub initialize()
chois = ""
Call disableallexceptnew
Call freshprojnames
End Sub
