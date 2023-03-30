VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmSplash 
   BackColor       =   &H8000000A&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   6660
   ClientLeft      =   990
   ClientTop       =   975
   ClientWidth     =   9855
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmSplash.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6660
   ScaleWidth      =   9855
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      BackColor       =   &H80000013&
      BorderStyle     =   0  'None
      ForeColor       =   &H8000000B&
      Height          =   6795
      Left            =   0
      TabIndex        =   0
      Top             =   -120
      Width           =   10065
      Begin ComctlLib.ProgressBar pbar 
         Height          =   255
         Left            =   2160
         TabIndex        =   1
         Top             =   6120
         Width           =   5295
         _ExtentX        =   9340
         _ExtentY        =   450
         _Version        =   327682
         BorderStyle     =   1
         Appearance      =   1
         MouseIcon       =   "frmSplash.frx":000C
      End
      Begin VB.Timer Timer1 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   240
         Top             =   6240
      End
      Begin VB.Label lload 
         BackColor       =   &H80000013&
         Caption         =   "Label2"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   9.75
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   255
         Left            =   480
         TabIndex        =   9
         Top             =   4800
         Width           =   3375
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BackColor       =   &H80000013&
         Caption         =   "PS-DS"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   27.75
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   765
         Left            =   240
         TabIndex        =   8
         Top             =   360
         Width           =   2085
      End
      Begin VB.Label tpbar 
         AutoSize        =   -1  'True
         BackColor       =   &H80000013&
         Caption         =   "Version"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   12
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   285
         Left            =   3855
         TabIndex        =   7
         Top             =   5400
         Width           =   2145
      End
      Begin VB.Label lblCompanyProduct 
         AutoSize        =   -1  'True
         BackColor       =   &H80000013&
         Caption         =   "Project Scheduler By"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   26.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   645
         Left            =   2640
         TabIndex        =   6
         Top             =   1800
         Width           =   5010
      End
      Begin VB.Label lblLicenseTo 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000013&
         Caption         =   "LicenseTo Dsoft"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   14.25
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   615
         Left            =   6960
         TabIndex        =   5
         Top             =   480
         Width           =   2655
      End
      Begin VB.Label lblProductName 
         AutoSize        =   -1  'True
         BackColor       =   &H80000013&
         Caption         =   "Dsoft"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   72
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   1680
         Left            =   3000
         TabIndex        =   4
         Top             =   2640
         Width           =   3975
      End
      Begin VB.Label lblPlatform 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         BackColor       =   &H80000013&
         Caption         =   "Platform"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   18
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   420
         Left            =   6840
         TabIndex        =   3
         Top             =   4320
         Width           =   1620
      End
      Begin VB.Label lblVersion 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         BackColor       =   &H80000013&
         Caption         =   "Version"
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   12
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF8080&
         Height          =   285
         Left            =   8520
         TabIndex        =   2
         Top             =   4920
         Width           =   945
      End
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim I As Integer
Dim j As Boolean
Dim tmp(50) As String
Dim interval As Integer


Private Sub Form_Load()

If dn.cn.State = adStateOpen Then dn.cn.Close

If Not inregistry() Then
        If MsgBox("There Must a Data Base For The Scheduler." & vbCrLf & _
                  "If you own one give the details of the Data Base." & vbCrLf & _
                  "Select yes for continue!!!", vbYesNo, "No Data Base Connected!!!") = vbYes Then
                  
            registry.Show vbModal, Me
            Call Form_Load
            Exit Sub
        Else
            Call del_registry
            Unload Me
            Exit Sub
        End If
End If
    
    
    I = 1
    j = False
    tmp(1) = "Project Scheduler.mnu"
    tmp(2) = "View.mnu"
    tmp(3) = "Introduction.frm"
    tmp(4) = "Adminform.frm"
    tmp(4) = "New.exe"
    tmp(5) = "Project Resheduler.dll"
    tmp(6) = "Garn.dll"
    tmp(7) = "date calculator demo.ocx"
    tmp(8) = "property1"
    tmp(9) = "property2"
    tmp(10) = "Newexsistingproperty3"
    tmp(11) = "ProjectModule1.bas"
    tmp(12) = "codecomponent.ocx"
    tmp(13) = "registerperson"
    tmp(14) = "register"
    tmp(15) = "admin register"
    tmp(16) = "Manager Register.mnu"
    tmp(17) = "Add.frm"
    tmp(18) = "Connection.con"
    tmp(19) = "userid.dll"
    tmp(20) = "setpredsucc.frm"
    tmp(21) = "tmp1.frm"
    tmp(22) = "tmp2.frm"
    tmp(23) = "Master/child recordforms.ocx"
    tmp(24) = "Transaction.db"
    tmp(25) = "Reshedulesub.frm"
    tmp(26) = "Mgarn.frm"
    tmp(27) = "Change Manager form.FRM"
    tmp(28) = "Data Reporter.rdx"
    tmp(29) = "Desc.frm"
    tmp(30) = "special.dll"
    tmp(31) = "Criticalpath,findpath.bas"
    tmp(32) = "Changer for Duration.frm"
    interval = 0
    pbar.Min = 0
    pbar.Max = 100
    pbar.Value = 0
    Timer1.Enabled = True
End Sub


Private Sub Timer1_Timer()
On Error GoTo label
    I = I + 2
    If I >= 30 Then
        If j = False Then
            I = 2
            j = True
        Else
            I = 1
            j = False
        End If
    End If
    lload.Caption = "Loading " & tmp(I)
     
    interval = interval + 1
    pbar.Value = pbar.Value + (pbar.Max / 40)
    tpbar.Caption = "Complete " & Str(Int(pbar.Value)) & "%"
    If interval = 25 Then
          lload.Caption = "Connecting to Data Base..."
          If dn.cn.State = adStateClosed Then
                               
                db_type_oracle = IIf(GetSetting("project_scheduler", "data_base", "dprovider", "microsoft.jet.oledb.4.0") = "MSDAORA.1", True, False)
                
                If db_type_oracle Then
                        
                        dno.cno.Open "Provider=" & GetSetting("project_scheduler", "data_base", "dprovider", "microsoft.jet.oledb.4.0") & ";" & _
                                     "Data Source=" & GetSetting("project_scheduler", "data_base", "dsource", "pshedule.mdb") & ";User Id=" & _
                                     GetSetting("project_scheduler", "data_base", "duser", "admin") & ";Password=" & _
                                     GetSetting("project_scheduler", "data_base", "dpass", "")
            
                        Set dn.cn = dno.cno
                
                Else
    
                        dna.cna.Open "Provider=" & GetSetting("project_scheduler", "data_base", "dprovider", "microsoft.jet.oledb.4.0") & ";" & _
                                     "Data Source=" & GetSetting("project_scheduler", "data_base", "dsource", "pshedule.mdb") & ";User Id=" & _
                                     GetSetting("project_scheduler", "data_base", "duser", "admin") & ";Password=" & _
                                     GetSetting("project_scheduler", "data_base", "dpass", "")
         
                        Set dn.cn = dna.cna
                End If
          End If
    End If
    
    If interval >= 40 Then
        Timer1.Enabled = False
        Unload Me
        introduction.Show
    End If
Exit Sub

label:
    MsgBox "ERROR:" & Err.Description & vbCrLf & vbCrLf & "ERROR NUMBER:" & Str(Err.Number) & _
    vbCrLf & vbCrLf & "SOURCE OF ERROR:" & Err.Source, vbOKOnly, "DATA BASE CONNECTION ERROR"

Call del_registry
Call Form_Load
End Sub
