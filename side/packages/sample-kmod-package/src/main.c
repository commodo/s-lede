#include <linux/init.h>
#include <linux/module.h>

static int __init sample_kmod_app_init(void)
{
	pr_info("sample_kmod_app loaded\n");
	return 0;
}

static void __exit sample_kmod_app_exit(void)
{
	pr_info("sample_kmod_app unloaded\n");
}

module_init(sample_kmod_app_init);
module_exit(sample_kmod_app_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Alexandru Ardelean <ardeleanalex@gmail.com>");
MODULE_DESCRIPTION("Side LEDE: sample kmod");
