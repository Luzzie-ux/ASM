#include <stdio.h>
#include <unistd.h>

extern ssize_t ft_write(int fd, void *buf, size_t count);

int main(void)
{	
	char *str = "Hello, World!\n";
	ssize_t i = ft_write(1, str, 14);
	printf("%ld\n", i);
	return 0;
}
