/*
 * Copyright (C) 2013 The Android Open Source Project
 * Copyright (C) 2017 Jesse Chan <cjx123@outlook.com>
 * Copyright (C) 2018 Lukas Berger <mail@lukasberger.at>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <hardware/hardware.h>
#include <hardware/power.h>

using namespace std;

#ifndef EXYNOS5_POWER_HAL_POWER_H_INCLUDED
#define EXYNOS5_POWER_HAL_POWER_H_INCLUDED

#define PROFILE_INVALID             -2

#define PROFILE_SCREEN_OFF          -1
#define PROFILE_POWER_SAVE           0
#define PROFILE_BALANCED             1
#define PROFILE_HIGH_PERFORMANCE     2
#define PROFILE_BIAS_POWER_SAVE      3
#define PROFILE_BIAS_PERFORMANCE     4

#define PROFILE_MAX_USABLE           5

#define POWER_DT2W_ENABLED                "/sys/android_touch/doubletap2wake"
#define POWER_TOUCHKEYS_ENABLED           "/sys/class/sec/sec_touchkey/input/enabled"
#define POWER_TOUCHSCREEN_NAME            "/sys/class/input/input1/name"
#define POWER_TOUCHSCREEN_NAME_EXPECT     "sec_touchscreen"
#define POWER_TOUCHSCREEN_ENABLED_FLAT    "/sys/class/input/input1/enabled"
#define POWER_TOUCHSCREEN_ENABLED_EDGE    "/sys/class/input/input0/enabled"
#define POWER_TOUCHKEYS_BRIGHTNESS        "/sys/class/sec/sec_touchkey/brightness"
#define POWER_FINGERPRINT_REGULATOR       "/sys/class/fingerprint/fingerprint/regulator"
#define POWER_FINGERPRINT_WAKELOCKS       "/sys/class/fingerprint/fingerprint/wakelocks"

#define POWER_DEFAULT_BOOSTPULSE    50000

#ifdef POWER_MULTITHREAD_LOCK_PROTECTION
  #define POWER_LOCK()      pthread_mutex_lock(&power->lock)
  #define POWER_UNLOCK()    pthread_mutex_unlock(&power->lock)
#else
  #define POWER_LOCK()      do { } while(0)
  #define POWER_UNLOCK()    do { } while(0)
#endif /* POWER_MULTITHREAD_LOCK_PROTECTION */

enum sec_device_variant {
	FLAT,
	EDGE
};

struct sec_power_module {

	struct power_module base;
	pthread_mutex_t lock;

	bool initialized;
	bool dozing;

	enum sec_device_variant variant;

	struct {
		int current;
		int requested;
	} profile;

	struct {
		bool touchkeys_enabled;
		bool dt2w;
		string touchscreen_control_path;
	} input;

};

/** Initializing */
static int power_open(const hw_module_t *module, const char *name, hw_device_t **device);
static void power_init(struct power_module *module);

/** Hinting */
static void power_hint(struct power_module *module, power_hint_t hint, void *data);

/** Profiles */
static void power_set_profile(struct sec_power_module *power, int profile);
static void power_reset_profile(struct sec_power_module *power);

/** Boost */
static void power_boostpulse(struct sec_power_module *power, int duration);
static void power_boostpulse_cpu(struct sec_power_module *power, int core, int duration);
static void power_boostpulse_cpu_cpugov(int core, int duration);
static void power_boostpulse_cpu_fallback(struct sec_power_module *power, int core, int duration);

/** Inputs */
static void power_fingerprint_state(bool state);
static void power_dt2w_state(struct sec_power_module *power, bool state);
static void power_input_device_state(struct sec_power_module *power, bool state);
static void power_set_interactive(struct power_module* module, int on);

/** Features */
static int power_get_feature(struct power_module *module, feature_t feature);
static void power_set_feature(struct power_module *module, feature_t feature, int state);

#endif // EXYNOS5_POWER_HAL_POWER_H_INCLUDED
