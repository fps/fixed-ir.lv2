#include <cmath>
#include <vector>
#include <lv2.h>
#include <samplerate.h>
#include "vendored/FFTConvolver/FFTConvolver.h"

#include "irs.c"

#define FIXED_IR_URI "https://dfdx.eu/fps-plugins.lv2/fixed-ir-COLLECTION.lv2"

struct plugin
{
    float m_sample_rate;
    std::vector<float *> m_ports;
    std::vector<fftconvolver::FFTConvolver> m_convolvers;

    plugin (double sample_rate) :
        m_sample_rate(sample_rate),
        m_ports(5),
        m_convolvers(n_IR)
    {
        for (size_t n = 0; n < n_IR; ++n)
        {
            double src_ratio = sample_rate / IRs[n]->sample_rate;
            size_t size_out = std::ceil(src_ratio * IRs[n]->n_samples);
            float src_out[size_out] = { 0 };
            SRC_DATA src_data = {
                IRs[n]->sample_data,
                src_out,
                IRs[n]->n_samples,
                (long)size_out,
                0,
                0,
                0,
                src_ratio
            };

            int ret = src_simple(&src_data, SRC_SINC_BEST_QUALITY, 1);

            m_convolvers[n].init(32, src_out, size_out);
        }
    }
};

static void connect_port (LV2_Handle instance, uint32_t port, void *data_location)
{
    if (port >= ((plugin*)instance)->m_ports.size()) {
        return;
    }

    plugin &p = *((plugin*)instance);
    p.m_ports[port] = (float*)data_location;
}

LV2_Handle instantiate
(
    const struct LV2_Descriptor *descriptor,
    double sample_rate,
    const char *bundle_path,
    const LV2_Feature *const *features
)
{
    plugin *instance = new plugin (sample_rate);
    return (LV2_Handle)instance;
}

static void activate (LV2_Handle instance)
{

}

static void cleanup(LV2_Handle instance)
{
    delete (plugin*)instance;
}

#define EPSILON 0.0001f

static void run
(
    LV2_Handle instance,
    uint32_t sample_count
) 
{
    plugin &the_plugin = *((plugin*)instance);

    // Audio ports
    const float *in       =  the_plugin.m_ports[0];
    float       *out      =  the_plugin.m_ports[1];

    // Control eports
    const float &gain     = *the_plugin.m_ports[2];
    const float &dry_wet  = *the_plugin.m_ports[3];
    int         ir        = *the_plugin.m_ports[4];

    float gain_factor = powf(10.0f, gain/20.0f);

    ir = std::min(std::max(0, ir), NUMBER_OF_IRS - 1);

    the_plugin.m_convolvers[ir].process(in, out, sample_count);

    for (size_t n = 0; n < sample_count; ++n) {
        out[n] = dry_wet * out[n] + (1.0f - dry_wet) * in[n];
        out[n] *= gain_factor;
    }
}

static LV2_Descriptor plugin_descriptor = {
    FIXED_IR_URI,
    instantiate,
    connect_port,
    activate,
    run,
    0,
    cleanup,
    0
};

LV2_SYMBOL_EXPORT const LV2_Descriptor* lv2_descriptor (uint32_t index) {
    if (0 == index) {
        return &plugin_descriptor;
    } else {
        return NULL;
    }
}

