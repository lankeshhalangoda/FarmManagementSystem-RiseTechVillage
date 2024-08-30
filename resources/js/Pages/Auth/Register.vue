<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const year = new Date().getFullYear();

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>

        <Head title="Register" />

        <div class="col-lg-6 d-md-flex align-items-center order-2 order-lg-1">
            <div class="p-3 p-lg-5">
                <img src="../../../src/images/element/signup.jpg" alt="">
            </div>
            <div class="vr opacity-1 d-none d-lg-block"></div>
        </div>

        <div class="col-lg-6 order-1">
            <div class="p-4 p-sm-6">
                <Link :href="route('register')">
                <img class="h-50px mb-4" src="../../../src/images/logo.svg" alt="logo">
                </Link>
                <h1 class="mb-2 h3">Create An Account</h1>
                <p class="mb-0">Already a member?
                    <Link :href="route('login')"> Log in</Link>
                </p>

                <form class="mt-4 text-start" @submit.prevent="submit">
                    <div class="mb-3">
                        <label class="form-label" for="name">Name</label>
                        <input type="text" class="form-control" id="name" v-model="form.name" required autofocus
                            autocomplete="name">
                        <InputError :message="form.errors.name" class="text-danger mt-2" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Enter email id</label>
                        <input type="email" class="form-control" id="email" v-model="form.email" required
                            autocomplete="email">
                        <InputError :message="form.errors.email" class="text-danger mt-2" />
                    </div>
                    <div class="mb-3 position-relative">
                        <label class="form-label">Enter password</label>
                        <input class="form-control fakepassword" type="password" id="psw-input" v-model="form.password"
                            required autocomplete="new-password">
                        <InputError :message="form.errors.password" class="text-danger mt-2" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" id="psw-confirm"
                            v-model="form.password_confirmation" required autocomplete="new-password">
                        <InputError :message="form.errors.password_confirmation" class="text-danger mt-2" />
                    </div>
                    <div class="mb-3">
                        <input type="checkbox" class="form-check-input" id="rememberCheck" />
                        <label class="form-check-label" for="rememberCheck">&nbsp;Keep me signed in</label>
                    </div>
                    <div>
                        <button type="submit" class="btn btn-primary w-100 mb-0"
                            :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                            Sign up
                        </button>
                    </div>
                    <div class="position-relative my-4">
                        <hr>
                        <p class="small position-absolute top-50 start-50 translate-middle bg-mode px-1 px-sm-2">
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </GuestLayout>
</template>
