VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form changemanagerform 
   Caption         =   "CHANGE MANAGERS OF PROJECT/TASKS"
   ClientHeight    =   6195
   ClientLeft      =   735
   ClientTop       =   1605
   ClientWidth     =   10545
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "changemanagerform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6195
   ScaleWidth      =   10545
   Begin VB.Frame fprojects 
      Caption         =   "SELECT SUBTASK"
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
      Index           =   1
      Left            =   120
      TabIndex        =   9
      Top             =   3360
      Width           =   10335
      Begin VB.Frame fprojectid 
         Caption         =   "SELECT SUBTASK NAME"
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
         Index           =   1
         Left            =   120
         TabIndex        =   10
         Top             =   840
         Width           =   2535
         Begin VB.ComboBox projectidcombo 
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
            Index           =   1
            Left            =   120
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   240
            Width           =   2295
         End
      End
      Begin VB.Frame finfo 
         Caption         =   "SUBTASK DETAILS"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Index           =   1
         Left            =   2760
         TabIndex        =   12
         Top             =   240
         Width           =   7455
         Begin VB.CommandButton ccancel 
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
            Index           =   1
            Left            =   5760
            TabIndex        =   17
            Top             =   1440
            Width           =   1575
         End
         Begin VB.CommandButton cok 
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
            Index           =   1
            Left            =   5760
            TabIndex        =   16
            Top             =   960
            Width           =   1575
         End
         Begin VB.Frame fdatepick 
            Caption         =   "SUBTASK ASSIGNED DATE FOR NEW MANAGER"
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
            Index           =   1
            Left            =   120
            TabIndex        =   13
            Top             =   1320
            Width           =   4335
            Begin MSComCtl2.DTPicker newdate 
               Height          =   375
               Index           =   1
               Left            =   960
               TabIndex        =   14
               Top             =   240
               Width           =   2175
               _ExtentX        =   3836
               _ExtentY        =   661
               _Version        =   393216
               Format          =   61472769
               CurrentDate     =   38161
            End
         End
         Begin VB.CommandButton cnewman 
            Caption         =   "SELECT NEW ID"
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
            Index           =   1
            Left            =   5760
            TabIndex        =   15
            Top             =   480
            Width           =   1575
         End
         Begin VB.Label loldman 
            Caption         =   "Label1"
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
            Index           =   1
            Left            =   120
            TabIndex        =   21
            Top             =   360
            Width           =   2655
         End
         Begin VB.Label lnewman 
            Caption         =   "Label1"
            BeginProperty Font 
               Name            =   "Book Antiqua"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   975
            Index           =   1
            Left            =   3000
            TabIndex        =   20
            Top             =   360
            Width           =   2655
         End
      End
   End
   Begin VB.Frame fprojects 
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
      Height          =   2535
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   10335
      Begin VB.Frame finfo 
         Caption         =   "PROJECT DETAILS"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Index           =   0
         Left            =   2760
         TabIndex        =   3
         Top             =   240
         Width           =   7455
         Begin VB.CommandButton cnewman 
            Caption         =   "SELECT NEW ID"
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
            Index           =   0
            Left            =   5760
            TabIndex        =   6
            Top             =   480
            Width           =   1575
         End
         Begin VB.Frame fdatepick 
            Caption         =   "PROJECT ASSIGNED DATE FOR NEW MANAGER"
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
            Index           =   0
            Left            =   120
            TabIndex        =   4
            Top             =   1320
            Width           =   4215
            Begin MSComCtl2.DTPicker newdate 
               Height          =   375
               Index           =   0
               Left            =   960
               TabIndex        =   5
               Top             =   240
               Width           =   2175
               _ExtentX        =   3836
               _ExtentY        =   661
               _Version        =   393216
               Format          =   61472769
               CurrentDate     =   38161
            End
         End
         Begin VB.CommandButton cok 
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
            Index           =   0
            Left            =   5760
            TabIndex        =   7
            Top             =   960
            Width           =   1575
         End
         Begin VB.CommandButton ccancel 
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
            Index           =   0
            Left            =   5760
            TabIndex        =   8
            Top             =   1440
            Width           =   1575
         End
         Begin VB.Label lnewman 
            Caption         =   "Label1"
            BeginProperty Font 
               Name            =   "Book Antiqua"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   975
            Index           =   0
            Left            =   3000
            TabIndex        =   19
            Top             =   360
            Width           =   2655
         End
         Begin VB.Label loldman 
            Caption         =   "Label1"
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
            Index           =   0
            Left            =   120
            TabIndex        =   18
            Top             =   360
            Width           =   2775
         End
      End
      Begin VB.Frame fprojectid 
         Caption         =   "SELECT PROJECT-ID"
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
         Index           =   0
         Left            =   120
         TabIndex        =   1
         Top             =   840
         Width           =   2535
         Begin VB.ComboBox projectidcombo 
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
            Index           =   0
            Left            =   120
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   240
            Width           =   2295
         End
      End
   End
   Begin VB.Menu reselectmanager 
      Caption         =   "RESELECT-MANAGER"
      Begin VB.Menu reselsectprojectmanager 
         Caption         =   "RESELECT-PROJECT-MANAGER"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu reselecttaskmanager 
         Caption         =   "RESELECT-TASK-MANAGER"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu exitreselect 
         Caption         =   "EXIT-RESELECTION"
      End
   End
End
Attribute VB_Name = "changemanagerform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim chois As Integer
Dim proj_count As Integer
Dim task_count As Integer

Dim projs() As projectinfo
Dim tasks() As taskinfo

Public sel_cde As Long
Public sel_nam As String
Public clicked As Integer



Private Sub initialize_projects()
On Error GoTo cancel
Dim I As Integer
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

cnewman(0).Enabled = False
cnewman(1).Enabled = False

cok(0).Enabled = False
cok(1).Enabled = False
ccancel(0).Enabled = False
ccancel(1).Enabled = False
loldman(0).Caption = ""
loldman(1).Caption = ""
lnewman(0).Caption = ""
lnewman(1).Caption = ""
projectidcombo(0).clear
projectidcombo(1).clear
fprojects(0).Enabled = False
fprojects(1).Enabled = False
newdate(0).Value = DateValue("01/01/2004")
newdate(1).Value = DateValue("01/01/2004")

Set Y = X.Execute("select projid,projmanager,name from projects pro,person po" _
         & " where(pro.completed='F' and pro.deleted='F' and po.id=pro.projmanager)")
         
If Y.RecordCount > 0 Then
    ReDim projs(Y.RecordCount) As projectinfo
    I = 0
    Y.MoveFirst
    While Not Y.EOF
        projectidcombo(0).AddItem (Y("projid"))
        projectidcombo(0).ItemData(projectidcombo(0).NewIndex) = I
        projs(I).man = Val(Y("projmanager"))
        projs(I).name = Y("name")
        I = I + 1
        Y.MoveNext
    Wend
    proj_count = I
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub initialize_tasks(pcde As Integer)
On Error GoTo cancel
Dim I As Integer
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

projectidcombo(1).clear
fprojects(0).Enabled = False
fprojects(1).Enabled = False

Set Y = X.Execute("select su.taskname as taskname,su.taskid as taskid,su.taskmanager as taskmanager,po.name as name from subtasks su" _
        & ",person po where(su.projid=" & pcde & " and su.taskid in(select distinct(sa.taskid) " _
        & " from subtasksassignedto sa where(sa.projid=" & pcde & " and sa.personid=su.taskmanager and " _
        & " sa.status='I' and sa.taskid=su.taskid)) and po.id=su.taskmanager)")

If Y.RecordCount > 0 Then
    ReDim tasks(Y.RecordCount) As taskinfo
    I = 0
    Y.MoveFirst
    While Not Y.EOF
        projectidcombo(1).AddItem (Y("taskname"))
        projectidcombo(1).ItemData(projectidcombo(1).NewIndex) = I
        tasks(I).taskid = Val(Y("taskid"))
        tasks(I).man = Y("taskmanager")
        tasks(I).name = Y("name")
        I = I + 1
        Y.MoveNext
    Wend
    task_count = I
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub


Private Sub ccancel_Click(Index As Integer)
    Call initialize_projects
End Sub

Private Sub cnewman_Click(Index As Integer)
    clicked = Index
    Me.Hide
    personform.owner = "CHANGEMANAGER"
    personform.person_chois = "SELECT"
    personform.Show
End Sub


Private Sub cok_Click(Index As Integer)
On Error GoTo cancel
Dim I As Integer
Dim date1 As Date
Dim Y As New Recordset
Dim X As New Connection
Set X = dn.cn
If X.State = 0 Then X.Open

    If Index = 0 Then
        If chois = 0 Then
            If projectidcombo(0).ListIndex = -1 Then
                MsgBox "No Projects Selected!!!", vbOKOnly, "PROJECT SELECTION ERROR"
                If X.State = 1 Then X.Close
                Call ccancel_Click(0)
                Exit Sub
            Else
                If sel_cde = 0 Then
                    MsgBox "No Manager Selected For Replacement", vbOKOnly, "Selection Error"
                    If X.State = 1 Then X.Close
                    Call ccancel_Click(0)
                    Exit Sub
                End If
                Set Y = X.Execute("select assigneddate from projectsassignedto where(" _
                & "projid=" & Val(projectidcombo(0).Text) & " and personid=" & projs(projectidcombo(0).ItemData(projectidcombo(0).ListIndex)).man & _
                " and  status='I')")
                I = Y.RecordCount
                Y.MoveFirst
                date1 = DateValue(Format$(Y("assigneddate"), "mm/dd/yyyy"))
                If date1 > newdate(0).Value Then
                    MsgBox "You Cant Assign Project on This Date." & vbCrLf & _
                    "Because this date is Less than The date of Project Assignment," & vbCrLf _
                    & "of the old Manger.", vbOKOnly, "DATE ERROR!!!"
                    If X.State = 1 Then X.Close
                    Call ccancel_Click(0)
                    Exit Sub
                End If
                
                If db_type_oracle Then
                    Set Y = X.Execute("select * from projectsassignedto where(projid=" & Val(projectidcombo(0).Text) & " and personid=" & projs(projectidcombo(0).ItemData(projectidcombo(0).ListIndex)).man & _
                     " and  status='I' and assigneddate= '" & Format$(Str(newdate(0).Value), "dd-mmm-yyyy") & "')")
                Else
                     Set Y = X.Execute("select * from projectsassignedto where(projid=" & Val(projectidcombo(0).Text) & " and personid=" & projs(projectidcombo(0).ItemData(projectidcombo(0).ListIndex)).man & _
                     " and  status='I' and assigneddate= cdate('" & Format$(Str(newdate(0).Value), "dd-mmm-yyyy") & "'))")
                End If
                
        
                If Y.RecordCount > 0 Then
                
                    MsgBox "Record with the Same Information Already exsists", vbOKOnly, "ERROR!!!"
                    If X.State = 1 Then X.Close
                    Call ccancel_Click(0)
                    Exit Sub
                
                Else
                    X.BeginTrans
                    X.Execute ("update projectsassignedto  set status='T' where(" _
                    & "projid=" & Val(projectidcombo(0).Text) & " and personid=" & projs(projectidcombo(0).ItemData(projectidcombo(0).ListIndex)).man & _
                    " and  status='I')")
                
                    X.Execute ("insert into projectsassignedto(personid,projid,assigneddate,status)  values(" & sel_cde & "," & Val(projectidcombo(0).Text) _
                    & ",'" & Format$(Str(newdate(0).Value), "dd-mmm-yyyy") & "','I')")
                    
                    
                    X.Execute ("update projects  set projmanager=" & sel_cde & "  where(" _
                    & "projid=" & Val(projectidcombo(0).Text) & "and deleted='F' and completed='F')")
                    
                    If MsgBox("ARE YOU SURE TO MAKE THIS CHANGE?", vbYesNo, "CONFIRM") = vbNo Then
                        X.RollbackTrans
                        If X.State = 1 Then X.Close
                        Call ccancel_Click(0)
                        Exit Sub
                    Else
                        X.CommitTrans
                        If X.State = 1 Then X.Close
                        Call ccancel_Click(0)
                        Exit Sub
                    End If
                    
                End If
                
            End If
        End If
    Else
        If chois = 1 Then
            If projectidcombo(1).ListIndex = -1 Then
                MsgBox "No SubTasks Selected!!!", vbOKOnly, "SUBTASK SELECTION ERROR"
                If X.State = 1 Then X.Close
                Call ccancel_Click(0)
                Exit Sub
           End If
            
           If db_type_oracle Then
                Set Y = X.Execute("select * from subtasksassignedto where(projid=" & Val(projectidcombo(0).Text) & " and personid=" & Val(tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).man) & _
                      " and taskid=" & Val(tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).taskid) & " and status='I' and assigneddate='" & Format$(Str(newdate(1).Value), "dd-mmm-yyyy") & "')")
           Else
                Set Y = X.Execute("select * from subtasksassignedto where(projid=" & Val(projectidcombo(0).Text) & " and personid=" & Val(tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).man) & _
                      " and taskid=" & Val(tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).taskid) & " and status='I' and assigneddate=cdate('" & Format$(Str(newdate(1).Value), "dd-mmm-yyyy") & "'))")
           End If
                           
                   
           If Y.RecordCount > 0 Then
                
                    MsgBox "Record with the Same Information Already exsists", vbOKOnly, "ERROR!!!"
                    If X.State = 1 Then X.Close
                    Call ccancel_Click(0)
                    Exit Sub
            
            Else
                If sel_cde = 0 Then
                    MsgBox "No Manager Selected For Replacement", vbOKOnly, "Selection Error"
                    If X.State = 1 Then X.Close
                    Call ccancel_Click(0)
                    Exit Sub
                End If
                Set Y = X.Execute("select assigneddate from subtasksassignedto where(" _
                & "projid=" & Val(projectidcombo(0).Text) & " and taskid=" & tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).taskid & " and personid=" & tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).man & _
                " and  status='I')")
                I = Y.RecordCount
                Y.MoveFirst
                date1 = DateValue(Format$(Y("assigneddate"), "mm/dd/yyyy"))
                If date1 > newdate(1).Value Then
                    MsgBox "You Cant Assign Task on This Date." & vbCrLf & _
                    "Because this date is Less than The date of Task Assignment," & vbCrLf _
                    & "of the old Manger.", vbOKOnly, "DATE ERROR!!!"
                    If X.State = 1 Then X.Close
                    Call ccancel_Click(0)
                    Exit Sub
                Else
                    X.BeginTrans
                    X.Execute ("update subtasksassignedto  set status='T' where(" _
                    & "projid=" & Val(projectidcombo(0).Text) & " and personid=" & tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).man & _
                    " and taskid=" & tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).taskid & " and status='I')")
                
                    X.Execute ("insert into subtasksassignedto(personid,projid,taskid,assigneddate,status)  values(" & sel_cde & "," & Val(projectidcombo(0).Text) _
                    & "," & tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).taskid & ",'" & Format$(Str(newdate(1).Value), "dd-mmm-yyyy") & "','I')")
                    
                    
                    X.Execute ("update subtasks  set taskmanager=" & sel_cde & "  where(" _
                    & "projid=" & Val(projectidcombo(0).Text) & "and taskid=" & tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).taskid & ")")
                    
                    If MsgBox("ARE YOU SURE TO MAKE THIS CHANGE?", vbYesNo, "CONFIRM") = vbNo Then
                        X.RollbackTrans
                        If X.State = 1 Then X.Close
                        Call ccancel_Click(0)
                        Exit Sub
                    Else
                        X.CommitTrans
                        If X.State = 1 Then X.Close
                        Call ccancel_Click(0)
                        Exit Sub
                    End If
                    
                End If
         End If
    End If
End If
Call ccancel_Click(0)
Exit Sub

cancel:
    MsgBox Err.Description
    Call ccancel_Click(0)
End Sub

Private Sub exitreselect_Click()
    Unload Me
End Sub


Private Sub Form_Load()
    Call initialize_projects
    chois = 0
End Sub

Private Sub Form_Unload(cancel As Integer)
    adminform.Show
End Sub

Private Sub projectidcombo_Click(Index As Integer)
    If Index = 0 Then
        If projectidcombo(0).ListIndex <> -1 Then
            loldman(0).Caption = "Project Manager:" & Trim(projs(projectidcombo(0).ItemData(projectidcombo(0).ListIndex)).name) _
                          & vbCrLf & "Personid:" & projs(projectidcombo(0).ItemData(projectidcombo(0).ListIndex)).man
            If chois = 1 Then
                Call initialize_tasks(Val(projectidcombo(0).Text))
                fprojects(1).Enabled = True
            
            Else
                cnewman(0).Enabled = True
                cok(0).Enabled = True
                ccancel(0).Enabled = True
            End If
        Else
            MsgBox "SELECT A PROJECT ID", vbOKOnly, "PROJECT NOT SELECTED"
        End If
    Else
        If projectidcombo(1).ListIndex <> -1 Then
            loldman(1).Caption = "Task Manager:" & Trim(tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).name) _
                          & vbCrLf & "Personid:" & tasks(projectidcombo(1).ItemData(projectidcombo(1).ListIndex)).man
            
            cnewman(1).Enabled = True
            cok(1).Enabled = True
            ccancel(1).Enabled = True
        Else
            MsgBox "SELECT A TASK", vbOKOnly, "TASK NOT SELECTED"
        End If
    
    End If
End Sub

Private Sub reselecttaskmanager_Click()
chois = 1
Call initialize_projects
fprojects(0).Enabled = True
finfo(0).Enabled = False
End Sub

Private Sub reselsectprojectmanager_Click()
        Call initialize_projects
        chois = 0
        fprojects(0).Enabled = True
        finfo(0).Enabled = True
        fprojects(1).Enabled = False
End Sub
