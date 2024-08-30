<script setup>
import GuestLayout from "@/Layouts/GuestLayout.vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import { ref } from "vue";

const year = new Date().getFullYear();

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const form = useForm({
    email: "",
    password: "",
    remember: false,
});

const passwordVisible = ref(false);

const togglePasswordVisibility = () => {
    passwordVisible.value = !passwordVisible.value;
};

const submit = () => {
    form.post(route("login"), {
        onFinish: () => form.reset("password"),
    });
};
</script>


<template>
    <GuestLayout>

        <Head title="Login" />

        <div class="col-lg-6 d-flex align-items-center order-2 order-lg-1">
            <div class="p-3 p-lg-5">
                <img src="../../../src/images/element/signin.jpg" alt="" />
            </div>
            <div class="vr opacity-1 d-none d-lg-block"></div>
        </div>

        <div class="col-lg-6 order-1">
            <div class="p-4 p-sm-7">

                <Link :href="route('login')">
                <img class="h-50px mb-4" src="../../../src/images/logo.svg" alt="logo" />
                </Link>

                <h1 class="mb-2 h3">Hello! Ready To Log In?</h1>
                <p class="mb-0">
                    New here?
                    <Link :href="route('register')"> Create an account</Link>
                </p>

                <form class="mt-4 text-start" @submit.prevent="submit">

                    <div class="mb-3">
                        <label class="form-label" for="email">Enter email id</label>
                        <input type="email" class="form-control" id="email" v-model="form.email" required autofocus
                            autocomplete="username" />
                        <span class="text-danger mt-3">{{ form.errors.email }}</span>
                    </div>

                    <div class="mb-3 position-relative">
                        <label class="form-label" for="psw-input">Enter password</label>
                        <input :type="passwordVisible ? 'text' : 'password'" class="form-control fakepassword"
                            id="psw-input" v-model="form.password" required autocomplete="current-password" />
                        <span class="position-absolute top-50 end-0 translate-middle-y p-0 mt-3">
                            <i @click="togglePasswordVisibility"
                                :class="passwordVisible ? 'fas fa-eye cursor-pointer p-2' : 'fas fa-eye-slash cursor-pointer p-2'" style="cursor: pointer;">
                            </i>
                        </span>
                        <span class="text-danger mt-3" >{{ form.errors.password }}</span>
                    </div>

                    <div class="mb-3 d-sm-flex justify-content-between">
                        <div>
                            <input type="checkbox" class="form-check-input" id="rememberCheck"
                                v-model="form.remember" />
                            <label class="form-check-label" for="rememberCheck">&nbsp;Remember me?</label>
                        </div>
                    </div>

                    <div>
                        <button type="submit" class="btn btn-primary w-100 mb-0"
                            :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                            Login
                        </button>
                    </div>

                    <div class="position-relative my-4">
                        <hr />
                        <p class="small bg-mode position-absolute top-50 start-50 translate-middle px-2">
                        </p>
                    </div>

                </form>

            </div>
        </div>
    </GuestLayout>
</template>
