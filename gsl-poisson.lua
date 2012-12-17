local ffi = require 'ffi'

ffi.cdf[[
typedef extern GSL_VAR; /* Had to replace define by typedef */

   typedef struct
     {
       const char *name;
       unsigned long int max;
       unsigned long int min;
       size_t size;
       void (*set) (void *state, unsigned long int seed);
       unsigned long int (*get) (void *state);
       double (*get_double) (void *state);
     }
   gsl_rng_type;

   typedef struct
     {
       const gsl_rng_type * type;
       void *state;
     }
   gsl_rng;

   const gsl_rng_type * gsl_rng_env_setup (void);
   GSL_VAR const gsl_rng_type *gsl_rng_default;
   gsl_rng *gsl_rng_alloc (const gsl_rng_type * T);
   void gsl_rng_free (gsl_rng * r);
   unsigned int gsl_ran_poisson (const gsl_rng * r, double mu);
]]

if jit.os == 'Linux' then
   return ffi.C
elseif jit.os == 'OSX' then
   return ffi.load('libgsl.0.dylib')
else
   return ffi.load('libgsl-0')
end
