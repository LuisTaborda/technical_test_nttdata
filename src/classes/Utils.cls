public class Utils {

    public static Boolean validateDocument(String accountNumber){
        if(accountNumber.length() == 14) return validaCNPJ();
        else if(accountNumber.length() == 11) return validaCPF();
        
        return false;
    }

    public static Boolean validaCNPJ(){return true;}
    public static Boolean validaCPF(){return true;}
}