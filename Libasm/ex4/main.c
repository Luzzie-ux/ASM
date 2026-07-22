#include <stdio.h>

extern long ft_strlen(const char *s);

int main(void)
{
	const char *str = "Hello, World!";
	printf("%ld\n", ft_strlen(str));
	return (0);
}