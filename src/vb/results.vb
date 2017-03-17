Public Module Results
    Public Class ParseSideResult
        Private _success As Boolean
        Private _side As Integer
        Private _errorMessage as String

        Public ReadOnly Property Success As Boolean
            Get
                Return _success
            End Get
        End Property

        Public ReadOnly Property Side As Integer
            Get
                Return _side
            End Get
        End Property

        Public ReadOnly Property ErrorMessage As String
            Get
                Return _errorMessage
            End Get
        End Property

        Private Sub New(ByVal success As Boolean)
            Me._success = success
        End Sub

        Public Sub New(ByVal side As Integer)
            Me.New(True)
            _side = side
        End Sub

        Public Sub New(ByVal errorMessage As String)
            Me.New(False)
            _errorMessage = errorMessage
        End Sub
        
    End Class

    Public Class MatrixResult
        Private _success As Boolean
        Private _matrix As Integer(,)
        Private _sum As Integer
        Private _side As Integer

        Public ReadOnly Property Success As Boolean
            Get
                Return _success
            End Get
        End Property

        Public ReadOnly Property Matrix As Integer(,)
            Get
                Return _matrix
            End Get
        End Property

        Public ReadOnly Property Sum As Integer
            Get
                Return _sum
            End Get
        End Property

        Public ReadOnly Property Side As Integer
            Get
                Return _side
            End Get
        End Property

        Public Sub New(ByVal matrix As Integer(,), ByVal sum As Integer, ByVal side As Integer, ByVal success As Boolean)
            Me._matrix = matrix
            Me._sum = sum
            Me._side = side
            Me._success = success
        End Sub

    End Class
End Module