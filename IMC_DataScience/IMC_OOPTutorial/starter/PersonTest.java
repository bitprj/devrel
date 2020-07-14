
public class PersonTest
{
	//A simple test file for Person.java. 
	
	public static void main(String[] args)
	{
		Person John = new Person("John", "Smith", 26);
		System.out.println(John.getFirstName());
		System.out.println(John.getLastName());
		System.out.println(John.getName());
		System.out.println(John.getAge());
		
		John.increaseAge();
		System.out.println(John.getAge());
		
		John.increaseAge(3);
		System.out.println(John.getAge());
	}
}