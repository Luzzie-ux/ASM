#include <stdio.h>
#include <unistd.h>

extern ssize_t ft_read(int fd, void *buf, size_t count);

int main(void)
{
	void		*buf;
	ssize_t		bytes;
	
	bytes = ft_read(0, buf, 25);
	printf("Bytes read from %p( %s ): %ld\n", buf, (char *)buf, bytes);
	return (0);
}