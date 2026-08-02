#include <unistd.h>
#include <stdio.h>

extern ssize_t ft_gets(char *buf, ssize_t size);

int main()
{
	ssize_t size = 16;
	char buffer[size];
	
	ssize_t bytes = ft_gets(buffer, size);
	printf("%s is %ld bytes\n", buffer, bytes);
	return 0;
}