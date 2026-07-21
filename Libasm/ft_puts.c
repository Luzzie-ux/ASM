#include <stdio.h>

extern int ft_write(int fd, void *buf, int count);

int main(void)
{	
	char *str = "Hello, World!\n";
	int i = ft_write(1, str, 14);
	printf("%d\n", i);
	return 0;
}
