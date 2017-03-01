class ConsoleUtil {
    [string] static Prompt ([string]$question){
        return Read-Host -Prompt $question
    }
}
# function Prompt{
#     param([String]$question)
#     return Read-Host -Prompt $question
# }