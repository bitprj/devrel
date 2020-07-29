public class Person
{
	//Coding this will be an exercise for the students participating in the lesson; incomplete code fragments will be used to initially demonstrate the concepts.
	//As this is a simple program, there isn't any comments within the body - the method and variable names are intended to be self-explanatory.

	private String firstName;
	private String lastName;
	private int age;

	public Person(String theirFirstName, String theirLastName){
		firstName = theirFirstName;
		lastName = theirLastName;
		age = -1;
	}

	public Person(String theirFirstName, String theirLastName, int theirAge){
		firstName = theirFirstName;
		lastName = theirLastName;
		age = theirAge;

		if(age < 0)
			age = -1;
	}

	public int getAge(){
		return age;
	}

	public String getFirstName(){
		return firstName;
	}

	public String getLastName(){
		return lastName;
	}

	public String getName(){
		String fullName = firstName + " " + lastName;
		return fullName;
	}

	public void setAge(int theirAge){
		if(theirAge >= 0)
			age = theirAge;
	}

	public void increaseAge(){
		if(age > -1)
			age++;
	}

	public void increaseAge(int ageIncrement){
		if(age > -1)
			age += ageIncrement;
	}
}
