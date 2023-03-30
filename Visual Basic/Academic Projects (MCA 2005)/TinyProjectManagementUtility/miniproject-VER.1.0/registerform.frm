VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "mshflxgd.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form register 
   Caption         =   "REGISTER FORM FOR PERSONS"
   ClientHeight    =   6075
   ClientLeft      =   570
   ClientTop       =   1770
   ClientWidth     =   10725
   Icon            =   "registerform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6075
   ScaleWidth      =   10725
   Begin VB.Timer ctimer 
      Interval        =   100
      Left            =   120
      Top             =   2400
   End
   Begin VB.Frame ftime 
      Caption         =   "-CURRENT TIME----CURRENT DATE-"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   6915
      TabIndex        =   26
      Top             =   30
      Width           =   3375
      Begin VB.Label cdates 
         Alignment       =   2  'Center
         Caption         =   " xxxxxxxxxx"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   9
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   28
         Top             =   240
         Width           =   1335
      End
      Begin VB.Label ctime 
         Alignment       =   2  'Center
         Caption         =   " xxxxxxxxxx"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   9
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   27
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Frame fflex 
      Caption         =   "PERSONNEL REGISTRY"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1815
      Left            =   75
      TabIndex        =   21
      Top             =   4230
      Width           =   10335
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid personflex 
         Height          =   1455
         Left            =   120
         TabIndex        =   22
         Top             =   240
         Width           =   10095
         _ExtentX        =   17806
         _ExtentY        =   2566
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
      End
   End
   Begin VB.Frame flook 
      Caption         =   "STARTTING AND ENDING DATE FOR SEARCHING"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   6315
      TabIndex        =   18
      Top             =   750
      Width           =   4335
      Begin MSComCtl2.DTPicker fixstart 
         Height          =   375
         Left            =   240
         TabIndex        =   19
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   61407233
         CurrentDate     =   37987.3958333333
      End
      Begin MSComCtl2.DTPicker fixend 
         Height          =   375
         Left            =   2640
         TabIndex        =   20
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   61407233
         CurrentDate     =   37987.3958333333
      End
   End
   Begin VB.Frame fregister 
      Caption         =   "REGISTER ENTRY"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2535
      Left            =   1875
      TabIndex        =   6
      Top             =   1590
      Width           =   7215
      Begin VB.CommandButton cregisternotok 
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
         Left            =   6120
         TabIndex        =   17
         Top             =   720
         Width           =   975
      End
      Begin VB.CommandButton cregisterOK 
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
         Left            =   6120
         TabIndex        =   16
         Top             =   240
         Width           =   975
      End
      Begin VB.Frame fremark 
         Caption         =   "-----------REMARKS-------------------DIFFICULTIES----------------------ERRORS----------------"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1215
         Left            =   120
         TabIndex        =   12
         Top             =   1200
         Width           =   6975
         Begin VB.TextBox terror 
            BeginProperty Font 
               Name            =   "Book Antiqua"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   4680
            MaxLength       =   150
            MultiLine       =   -1  'True
            TabIndex        =   15
            Top             =   360
            Width           =   2175
         End
         Begin VB.TextBox tdiffi 
            BeginProperty Font 
               Name            =   "Book Antiqua"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   2400
            MaxLength       =   150
            MultiLine       =   -1  'True
            TabIndex        =   14
            Top             =   360
            Width           =   2175
         End
         Begin VB.TextBox tremark 
            BeginProperty Font 
               Name            =   "Book Antiqua"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   120
            MaxLength       =   150
            MultiLine       =   -1  'True
            TabIndex        =   13
            Top             =   360
            Width           =   2175
         End
      End
      Begin VB.Frame fregtime 
         Caption         =   "ENTRY && LEAVING TIME(HH:MM:SS)"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   2400
         TabIndex        =   9
         Top             =   360
         Width           =   3615
         Begin MSComCtl2.DTPicker entertime 
            Height          =   375
            Left            =   240
            TabIndex        =   10
            Top             =   240
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   661
            _Version        =   393216
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Book Antiqua"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Format          =   61407234
            UpDown          =   -1  'True
            CurrentDate     =   38158.3958333333
         End
         Begin MSComCtl2.DTPicker leavetime 
            Height          =   375
            Left            =   2040
            TabIndex        =   11
            Top             =   240
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   661
            _Version        =   393216
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Book Antiqua"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Format          =   61407234
            UpDown          =   -1  'True
            CurrentDate     =   38158.3958333333
         End
      End
      Begin VB.Frame fenterdate 
         Caption         =   "DATE(MM/DD/YYYY)"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   240
         TabIndex        =   7
         Top             =   360
         Width           =   2055
         Begin MSComCtl2.DTPicker entrydate 
            Height          =   375
            Left            =   240
            TabIndex        =   8
            Top             =   240
            Width           =   1695
            _ExtentX        =   2990
            _ExtentY        =   661
            _Version        =   393216
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Book Antiqua"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Format          =   61407233
            CurrentDate     =   37987.3958333333
         End
      End
   End
   Begin VB.Frame fprojectselect 
      Caption         =   "PERSON-PROJECT-TASK-SELECTION"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   75
      TabIndex        =   0
      Top             =   270
      Width           =   6135
      Begin VB.ComboBox personidcombo 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         ItemData        =   "registerform.frx":030A
         Left            =   120
         List            =   "registerform.frx":030C
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   720
         Width           =   1575
      End
      Begin VB.CommandButton taskcancel 
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
         Left            =   5040
         TabIndex        =   5
         Top             =   720
         Width           =   855
      End
      Begin VB.ComboBox projidcombo 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         ItemData        =   "registerform.frx":030E
         Left            =   1680
         List            =   "registerform.frx":0310
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   720
         Width           =   1335
      End
      Begin VB.ComboBox tasknamecombo 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         ItemData        =   "registerform.frx":0312
         Left            =   3000
         List            =   "registerform.frx":0314
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   720
         Width           =   1935
      End
      Begin VB.CommandButton taskok 
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
         Left            =   5040
         TabIndex        =   4
         Top             =   240
         Width           =   855
      End
      Begin VB.Label l3 
         Caption         =   "PERSON-ID"
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
         Left            =   360
         TabIndex        =   25
         Top             =   360
         Width           =   975
      End
      Begin VB.Label l2 
         Caption         =   "PROJECT-ID"
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
         Left            =   1800
         TabIndex        =   24
         Top             =   360
         Width           =   975
      End
      Begin VB.Label l1 
         Caption         =   "TASK NAME"
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
         Left            =   3360
         TabIndex        =   23
         Top             =   360
         Width           =   1335
      End
   End
   Begin VB.Menu person 
      Caption         =   "PERSON"
      Begin VB.Menu newentry 
         Caption         =   "NEW-ENTRY"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu exitreg 
         Caption         =   "EXIT-REGISTER"
      End
   End
   Begin VB.Menu view 
      Caption         =   "VIEW"
      Begin VB.Menu viewperson 
         Caption         =   "VIEW-PERSON"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu viewpersondate 
         Caption         =   "EXPLORE-PERSON-WITH-DATE"
      End
   End
End
Attribute VB_Name = "register"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim view_person As Integer
Public reg_chois As String
Public reg_id As Long


Private Sub cregisternotok_Click()
    Call disableall_not_menu
End Sub

Private Sub cregisterOK_Click()
On Error GoTo cancel
Dim X As New Connection
Dim date1 As Date

    If isallpredecessorscompleted(Val(projidcombo), tasknamecombo.ItemData(tasknamecombo.ListIndex), _
        date1) = False Or entrydate.Value < date1 Then
            MsgBox "YOU CANNOT MAKE ENTRY FOR THE TASK" & vbCrLf _
            & "BECAUSE THE STARTING DATE OF THIS TASK IS NOT REACHED" & vbCrLf _
            & "IT MAY DUE TO THE INCOMPLETION OF A PREDECESSORTASK OR PROJECT STARTDATE IS NOT REACHED", vbCritical, "REGISTRY ERROR!!!"
    Else
        If entertime.Value > leavetime.Value Then
            MsgBox "YOU ENTRY TIME IS GREATER THAN LEAVING TIME", vbCritical, "TIME ERROR!!!"
        Else
           Set X = dn.cn
           If X.State = 0 Then X.Open
           X.BeginTrans

           If db_type_oracle = True Then
                   X.Execute "insert into register(personid,projid,taskid,entrydate,enteringtime" _
                     & ",leavingtime,remarks,difficulties,errors) values(" & Val(personidcombo) & _
                     "," & Val(projidcombo) & "," & tasknamecombo.ItemData(tasknamecombo.ListIndex) & _
                     ",'" & Format$(Str(entrydate.Value), "dd-mmm-yyyy") & "',to_date('" & Format$(Str(entertime.Value), "ss:mm:hh AM/PM") & _
                     "','ss:mi:hh am'),to_date('" & Format$(Str(leavetime.Value), "ss:mm:hh AM/PM") & "','ss:mi:hh am'),'" _
                     & Trim(tremark) & "','" & Trim(tdiffi) & "','" & Trim(terror) & "')"
        
           Else
                    X.Execute "insert into register(personid,projid,taskid,entrydate,enteringtime" _
                      & ",leavingtime,remarks,difficulties,errors) values(" & Val(personidcombo) & _
                      "," & Val(projidcombo) & "," & tasknamecombo.ItemData(tasknamecombo.ListIndex) & _
                      ",'" & Format$(Str(entrydate.Value), "dd-mmm-yyyy") & "',cdate('" & Str(entertime.Value) & _
                      "'),cdate('" & Str(leavetime.Value) & "'),'" _
                      & Trim(tremark) & "','" & Trim(tdiffi) & "','" & Trim(terror) & "')"
           End If
           
           If MsgBox("ARE YOU SURE TO MAKE THIS ENTRY TO REGISTER", vbYesNo, "CONFIRM!!!") = vbYes Then
             X.CommitTrans
             Call disableall_not_menu
           Else
             X.RollbackTrans
           End If
        End If
    End If
Exit Sub
cancel:
    MsgBox Err.Description
    If X.State = adStateOpen Then
        X.RollbackTrans
    End If
End Sub

Private Sub ctimer_Timer()
    ctime.Caption = Format$(Now, "hh:mm:ss AM/PM")
    cdates.Caption = Format$(Now, "dd-mmm-yyyy")
End Sub

Private Sub exitreg_Click()
     Unload Me
End Sub



Public Sub disableall_not_menu()
Dim I As Integer

For I = 0 To Me.Count - 1
  If Me.Controls(I) <> ctime And Me.Controls(I) <> ctimer And Me.Controls(I) <> cdates Then
    Me.Controls(I).Enabled = True
  End If
  If TypeOf Me.Controls(I) Is Frame Then
     If Me.Controls(I) <> ftime Then
        Me.Controls(I).Visible = False
     End If
  End If
  If TypeOf Me.Controls(I) Is ComboBox Then
    Me.Controls(I).clear
  End If
  If TypeOf Me.Controls(I) Is TextBox Then
    Me.Controls(I).Text = ""
  End If
  If TypeOf Me.Controls(I) Is MSHFlexGrid Then
    If Me.Controls(I).rows > 2 Then Me.Controls(I).rows = 2
    Me.Controls(I).clear
  End If
Next I
fixstart.Value = DateValue(Format$(Now, "mm/dd/yyyy"))
fixend.Value = DateValue(Format$(Now, "mm/dd/yyyy"))
entrydate.Value = DateValue(Format$(Now, "mm/dd/yyyy"))
End Sub

Private Sub fixend_Change()
   Call reinitialize_grid
End Sub

Private Sub fixstart_Change()
    Call reinitialize_grid
End Sub

Private Sub Form_Load()
    Call disableall_not_menu
End Sub

Private Sub Form_Unload(cancel As Integer)
    If reg_chois = "PERSON" Or reg_chois = "MANAGER" Then
        introduction.Show
        
    Else
        adminform.Show
    End If
    
    reg_chois = ""
    reg_id = 0
End Sub

Private Sub newentry_Click()
On Error GoTo cancel
Dim tmp As String
Dim X As New Connection
Dim Y As New Recordset
    
    Call disableall_not_menu
    taskok.Enabled = True
    taskcancel.Enabled = True
    cregisterOK.Enabled = True
    cregisternotok.Enabled = True
    fprojectselect.Visible = True
    projidcombo.Enabled = False
    tasknamecombo.Enabled = False
    Set X = dn.cn
    view_person = 0
    If X.State = 0 Then X.Open
    If reg_chois = "PERSON" Then
        Set Y = X.Execute("select distinct(personid) as pid  from subtasksassignedto" _
                & " where(personid=" & reg_id & " and projid in(select projid from projects where (" _
                & " deleted='F' and completed='F')) and status='I')")
            Call addtocombobox(personidcombo, Y, "pid")
    Else
        Set X = dn.cn
        If X.State = 0 Then X.Open
        If reg_chois = "MANAGER" Then
            Set Y = X.Execute("select distinct(personid) as pid  from subtasksassignedto" _
                & " where(projid=" & reg_id & " and projid in(select projid from projects where (" _
                & " deleted='F' and completed='F')) and status='I')")
            Call addtocombobox(personidcombo, Y, "pid")
        Else
            If reg_chois = "ADMIN" Then
                Set Y = X.Execute("select distinct(personid) as pid from subtasksassignedto" _
                      & " where(projid in(select projid from projects where(deleted='F' and completed='F')) and status='I')")
                Call addtocombobox(personidcombo, Y, "pid")
             End If
        End If
    End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub


Private Sub personidcombo_Click()
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset
If personidcombo.ListIndex <> -1 Then
    Set X = dn.cn
    If X.State = 0 Then X.Open
    If view_person = 0 Then
        If reg_chois = "PERSON" Then
            Set Y = X.Execute("select distinct(projid) as pid from subtasksassignedto" _
                & " where(personid=" & Val(personidcombo) & " and projid in(select projid from " _
                & " projects where(deleted='F' and completed='F')) and status='I')")
        Else
            If reg_chois = "MANAGER" Then
                   Set Y = X.Execute("select distinct(projid) as pid from subtasksassignedto where (projid=" & reg_id _
                   & " and projid in(select projid from projects where(deleted='F' and completed='F')) and status='I')")
            Else
               Set Y = X.Execute("select distinct(projid) as pid from subtasksassignedto" _
                & " where(personid=" & Val(personidcombo) & " and projid in(select projid from " _
                & " projects where(deleted='F' and completed='F')) and status='I')")
            End If
        End If
    Else
        If reg_chois = "MANAGER" Then
            Set Y = X.Execute("select distinct(projid) as pid from subtasksassignedto" _
                & " where(projid=" & reg_id & " and projid in(select projid from " _
                & " projects where deleted='F') and (status='I' or status='C'))")
            
         Else
             If reg_chois = "PERSON" Then
                Set Y = X.Execute("select distinct(projid) as pid from subtasksassignedto" _
                & " where(personid=" & Val(personidcombo) & " and projid in(select projid from " _
                & " projects where deleted='F') and (status='I' or status='C'))")
             Else
                Set Y = X.Execute("select distinct(projid) as pid from subtasksassignedto" _
                & " where personid=" & Val(personidcombo) & "")
             End If
         End If
        
    End If
    
    Call addtocombobox(projidcombo, Y, "pid")
    projidcombo.Enabled = True
    tasknamecombo.clear
    tasknamecombo.Enabled = False
 Else
    MsgBox "NO ITEM SELECTED", vbOKOnly, "SELECTION ERROR"
End If

Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub projidcombo_Click()
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset
If projidcombo.ListIndex <> -1 Then
    Set X = dn.cn
    If X.State = 0 Then X.Open
    If view_person = 0 Then
       If reg_chois = "PERSON" Then
           Set Y = X.Execute("select taskname as tnam,taskid as tid from subtasks where" _
                & "(projid=" & Val(projidcombo) & " and taskmanager=" & Val(personidcombo) & " and projid in " _
                & "(select projid from projects where(deleted='F' and completed='F')))")
       Else
            If reg_chois = "MANAGER" Then
                Set Y = X.Execute("select taskname as tnam,taskid as tid from subtasks where" _
                & "(projid=" & reg_id & " and taskmanager=" & Val(personidcombo) & " and projid in " _
                & "(select projid from projects where(deleted='F' and completed='F')))")
            Else
                Set Y = X.Execute("select taskname as tnam,taskid as tid from subtasks where" _
                & "(projid=" & Val(projidcombo) & " and taskmanager=" & Val(personidcombo) & " and projid in " _
                & "(select projid from projects where(deleted='F' and completed='F')))")
            End If
       End If
    Else
         If reg_chois = "PERSON" Then
            Set Y = X.Execute("select taskname as tnam,taskid as tid from subtasks where" _
                & "(projid=" & Val(projidcombo) & " and taskmanager=" & Val(personidcombo) & " and projid in " _
                & "(select projid from projects where deleted='F' ))")
       Else
            If reg_chois = "MANAGER" Then
                Set Y = X.Execute("select taskname as tnam,taskid as tid from subtasks where" _
                & "(projid=" & reg_id & " and taskmanager=" & Val(personidcombo) & " and projid in " _
                & "(select projid from projects where deleted='F'))")
            Else
                Set Y = X.Execute("select taskname as tnam,taskid as tid from subtasks where" _
                & "(projid=" & Val(projidcombo) & " and taskmanager=" & Val(personidcombo) & ")")
            End If
       End If
    End If
    
    Call addtocombobox_extended(tasknamecombo, Y, "tnam", "tid")
    tasknamecombo.Enabled = True
Else
    MsgBox "NO ITEM SELECTED", vbOKOnly, "SELECTION ERROR"
End If

Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub taskcancel_Click()
    Call disableall_not_menu
End Sub



Private Sub taskok_Click()
    If personidcombo.ListIndex <> -1 And projidcombo.ListIndex <> -1 And tasknamecombo.ListIndex <> -1 Then
      If view_person = 0 Then
        fprojectselect.Enabled = False
        fregister.Visible = True
        fenterdate.Visible = True
        fregtime.Visible = True
        fremark.Visible = True
      Else
           fprojectselect.Enabled = False
           If view_person = 2 Then
                flook.Visible = True
           Else
                Call reinitialize_grid
           End If
           
      End If
      taskok.Enabled = False
      taskcancel.Enabled = False
    Else
         MsgBox "YOUR SELECTION IS NOT PROPER", vbOKOnly, "SELECTION ERROR"
     End If
 
End Sub




Private Sub tdiffi_KeyPress(pKey As Integer)
  If pKey = vbKeyBack Then pKey = vbKeyBack
End Sub

Private Sub terror_KeyPress(pKey As Integer)
If pKey = vbKeyBack Then pKey = vbKeyBack
End Sub

Private Sub tremark_KeyPress(pKey As Integer)
  If pKey = vbKeyBack Then pKey = vbKeyBack

End Sub

Private Sub reinitialize_grid()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

If view_person = 1 Then
    Set Y = X.Execute("select * from register where(personid=" & Val(personidcombo) _
    & " and projid=" & Val(projidcombo) & " and taskid=" & tasknamecombo.ItemData(tasknamecombo.ListIndex) & ")")
Else
    
    If Not db_type_oracle Then
        Set Y = X.Execute("select * from register where(personid=" & Val(personidcombo) _
        & " and projid=" & Val(projidcombo) & " and taskid=" & tasknamecombo.ItemData(tasknamecombo.ListIndex) _
        & " and  entrydate between cdate('" & Format$(Str(fixstart.Value), "dd-mmm-yyyy") & "') and cdate('" & Format$(Str(fixend.Value), "dd-mmm-yyyy") & "'))")
    Else
        Set Y = X.Execute("select * from register where(personid=" & Val(personidcombo) _
        & " and projid=" & Val(projidcombo) & " and taskid=" & tasknamecombo.ItemData(tasknamecombo.ListIndex) _
        & " and  entrydate between '" & Format$(Str(fixstart.Value), "dd-mmm-yyyy") & "' and '" & Format$(Str(fixend.Value), "dd-mmm-yyyy") & "')")
    End If

End If
personflex.clear
If Y.RecordCount <= 0 Then
    personflex.Enabled = False
    personflex.rows = 2
    personflex.cols = Y.Fields.Count + 1
    personflex.FixedRows = 1
Else
    personflex.Enabled = True
    personflex.clear
    personflex.cols = Y.Fields.Count + 1
    personflex.rows = 30
    personflex.ColWidth(5) = 2000
    personflex.ColWidth(6) = 2000
    personflex.ColWidth(7) = 1900
    personflex.ColWidth(8) = 2000
    personflex.ColWidth(9) = 2600
    personflex.FixedRows = 1
    Set personflex.Recordset = Y
    personflex.Col = 4
    personflex.Sort = 4
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub personflex_Click()
      personflex.cols = 10
      If personflex.rows > 1 And personflex.Row > 0 Then
            With personflex
                entrydate.Value = DateValue("01/01/2000")
                entertime.Value = DateValue("00:01:01")
                leavetime.Value = DateValue("00:01:01")
                If Trim(.TextMatrix(.Row, 4)) <> "" Then entrydate.Value = DateValue(.TextMatrix(.Row, 4))
                If Trim(.TextMatrix(.Row, 5)) <> "" Then entertime.Value = TimeValue(.TextMatrix(.Row, 5))
                If Trim(.TextMatrix(.Row, 6)) <> "" Then leavetime.Value = TimeValue(.TextMatrix(.Row, 6))
                tremark = ""
                tdiffi = ""
                terror = ""
                If Trim(.TextMatrix(.Row, 7)) <> "" Then tremark = .TextMatrix(.Row, 7)
                If Trim(.TextMatrix(.Row, 8)) <> "" Then tdiffi = .TextMatrix(.Row, 8)
                If Trim(.TextMatrix(.Row, 9)) <> "" Then terror = .TextMatrix(.Row, 9)
           End With
      End If
End Sub

Private Sub viewperson_Click()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
  
  Call disableall_not_menu
  view_person = 1
  taskok.Enabled = True
  taskcancel.Enabled = True
  cregisterOK.Enabled = False
  cregisternotok.Enabled = False
  fprojectselect.Visible = True
  fregister.Visible = True
  fregister.Enabled = False
  fenterdate.Visible = True
  fregtime.Visible = True
  fremark.Visible = True
  fflex.Visible = True
  fflex.Enabled = True
  Set X = dn.cn
  If X.State = 0 Then X.Open
    
    If reg_chois = "PERSON" Then
        personidcombo.AddItem (Str(reg_id))
    Else
        Set X = dn.cn
        If X.State = 0 Then X.Open
        If reg_chois = "MANAGER" Then
            
            Set Y = X.Execute("select distinct(personid) as pid  from subtasksassignedto" _
                & " where(projid=" & reg_id & " and projid in(select projid from projects where " _
                & " deleted='F') and (status='I' or status='C'))")
                      
            Call addtocombobox(personidcombo, Y, "pid")
        Else
            If reg_chois = "ADMIN" Then
                Set Y = X.Execute("select distinct(personid) as pid from subtasksassignedto")
                Call addtocombobox(personidcombo, Y, "pid")
             End If
        End If
    End If
Exit Sub

cancel:
    MsgBox Err.Description
 
 End Sub

Private Sub viewpersondate_Click()
  Call viewperson_Click
  view_person = 2
 End Sub
