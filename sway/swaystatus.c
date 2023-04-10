#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <locale.h>

static const char* load_avgs()
{
	FILE* fp;
	double loads[3] = {0};
	static char s[666];

	fp = fopen("/proc/loadavg", "r");
	if (!fp)
		return "???";

	setlocale(LC_ALL, "C");
	fscanf(fp, " %lf %lf %lf ", loads, loads+1, loads+2);
	setlocale(LC_ALL, "");
	fclose(fp);

	snprintf(s, sizeof (s), "%.2f %.2f %.2f", loads[0], loads[1], loads[2]);
	return s;
}

static const char* memory_used()
{
	FILE* fp;
	double total, available;
	static char s[666];

	fp = fopen("/proc/meminfo", "r");
	if (!fp)
		return "???";

	fscanf(fp, " MemTotal: %lf %*s MemFree: %*f %*s MemAvailable: %lf %*s",
		&total, &available);

	fclose(fp);

	snprintf(s, sizeof (s), "%.2f%%", 100 * (1 - available/total));
	return s;
}

static const char* battery_left()
{
	FILE* fp;
	double charge_full, charge_now;
	static char s[666];

	fp = NULL;
	fp = fp ? fp : fopen("/sys/class/power_supply/BAT0/charge_full", "r");
	fp = fp ? fp : fopen("/sys/class/power_supply/BAT0/energy_full", "r");
	if (!fp)
		return "???";
	fscanf(fp, "%lf", &charge_full);
	fclose(fp);

	fp = NULL;
	fp = fp ? fp : fopen("/sys/class/power_supply/BAT0/charge_now", "r");
	fp = fp ? fp : fopen("/sys/class/power_supply/BAT0/energy_now", "r");
	if (!fp)
		return "???";
	fscanf(fp, "%lf", &charge_now);
	fclose(fp);

	snprintf(s, sizeof (s), "%.2lf%%", 100 * charge_now / charge_full);
	return s;
}

static const char* localized_time()
{
           time_t t;
           struct tm* tmp;
           static char s[666];

           t = time(NULL);
           tmp = localtime(&t);

	   if (!tmp)
		   return "???";

	   if (strftime(s, sizeof(s), "%c", tmp) == 0)
		   return "???";

	   return s;
}

int main(void)
{
	setlocale(LC_ALL, "");

	for (;; sleep(1))
	{
		printf("L: %s | M: %s | B: %s | T: %s\n",
				load_avgs(),
				memory_used(),
				battery_left(),
				localized_time());
		fflush(stdout);
	}

	return 0;
}
