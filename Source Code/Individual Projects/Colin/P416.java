import java.util.Scanner;
public class P416
{
	private static Scanner scanner;
	public static void main(String[] args)
	{
		scanner = new Scanner(System.in);
		System.out.println("Enter numeral:");
		String original = scanner.next();
		StringBuilder builder = new StringBuilder();
		builder.append(original);
		builder.insert(6, "-");
		builder.insert(3, ") ");
		builder.insert(0, "(");
		System.out.println(builder.toString());
	}
}
