/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package proyectofinalbd1;

 
import java.sql.*;

public class conexion {

	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost/tienda";/* este nombre es el nombre de la base de datos? */
	String user,contra,aviso1,aviso2;
        int result;
	Connection con=null;
	
	public int conexion(String user, String contra) {
		this.user=user;
                   result=0;
		try {
			Class.forName(driver).newInstance();
			System.out.println("Se ha cargado correctamente el driver:"+driver);
			aviso1="Se ha cargado correctamente el driver: "+driver;		
		}
		catch (Exception e){
			
			System.out.println("Se ha producido el siguiente error al cargar el driver:\n"+e.getMessage());
		}
		
		try{
			con=DriverManager.getConnection(url,user,contra);
			System.out.println("Se ha conectado correctamente a la base de datos");
			System.out.println("Conection ==>"+(Object)con);
			aviso2="Se ha conectado correctamente a la base de datos";
		} 
		catch(Exception e){
                      result=-1;
			System.out.println("Se ha producido un error al momento de conectar la base de datos: \n"+e.getMessage());
                       
		}
/*
		try
		{
			stmt=con.createStatement();
			System.out.println("Statement==>"+(Object)stmt);
		}
		catch(SQLException sqle)
		{
			System.out.println("Se ha producido el siguiente error al crear un objeto Statement:\n"+sqle.getMessage());
		}			
*/
return result;
    }
    
   public Connection con(){
       try{
			con=DriverManager.getConnection(url,"root","admin1014");
			System.out.println("Se ha conectado correctamente a la base de datos123");
					} 
		catch(Exception e){
          
			System.out.println("Se ha producido un error al momento de conectar la base de datos: \n"+e.getMessage());
                       
		}
    	return con;
    }
    
    String rAviso1(){
    	return aviso1;
    }
    
    String rAviso2(){
    	return aviso2;
    }
}
