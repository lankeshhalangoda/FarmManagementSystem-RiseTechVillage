<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <GuestLayout>
        <Head title="Forgot Password" />

        <div class="forgot-password-container">
            <div class="forgot-password-card">
                <h1>Forgot Password</h1>

                <p class="description">
                    Forgot your password? No problem. Just enter your email address and we'll send you a link to reset your password.
                </p>

                <div v-if="status" class="status-message">
                    {{ status }}
                </div>

                <form @submit.prevent="submit">
                    <div class="input-group">
                        <InputLabel for="email" value="Email" class="input-label" />

                        <TextInput
                            id="email"
                            type="email"
                            class="custom-input"
                            v-model="form.email"
                            required
                            autofocus
                            autocomplete="username"
                        />

                        <InputError class="input-error" :message="form.errors.email" />
                    </div>

                    <div class="button-group">
                        <PrimaryButton
                            :class="{ 'button-loading': form.processing }"
                            :disabled="form.processing"
                            class="custom-button"
                        >
                            Email Password Reset Link
                        </PrimaryButton>
                    </div>
                </form>
            </div>
        </div>
    </GuestLayout>
</template>

<style scoped>


.forgot-password-card {
    background-color: #fff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
    text-align: center;
}

.forgot-password-card h1 {
    font-size: 2rem;
    color: #333;
    margin-bottom: 1.5rem;
    font-family: 'Poppins', sans-serif;
}

.forgot-password-card .description {
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 1.5rem;
}

.forgot-password-card .status-message {
    background-color: #e6f7e6;
    color: #27a744;
    border: 1px solid #27a744;
    padding: 0.5rem;
    border-radius: 5px;
    margin-bottom: 1rem;
}

.input-group {
    margin-bottom: 1.5rem;
    text-align: left;
}

.input-label {
    display: block;
    font-weight: 600;
    margin-bottom: 0.5rem;
    color: #555;
    font-family: 'Poppins', sans-serif;
}

.custom-input {
    width: 100%;
    padding: 0.75rem;
    border-radius: 8px;
    border: 1px solid #ccc;

    font-size: 1rem;
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.custom-input:focus {
    border-color: #9C9A6C;
    outline: none;
}

.input-error {
    color: #e74c3c;
    font-size: 0.85rem;
    margin-top: 0.5rem;
}

.button-group {
    margin-top: 2rem;
}

.custom-button {
    background-color: #9C9A6C;
    color: #fff;
    padding: 0.75rem 1.5rem;
    border-radius: 10px;
    font-size: 1rem;
    font-weight: 600;
    text-transform: uppercase;
    cursor: pointer;
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
    width: 100%;
}

.custom-button:hover {
    background-color: #228B22;
}

.custom-button:disabled {
    background-color: #95a5a6;
    cursor: not-allowed;
}

.button-loading {
    opacity: 0.6;
}

@media (max-width: 480px) {
    .forgot-password-card {
        padding: 1.5rem;
        width: 90%;
    }

    .custom-button {
        padding: 0.75rem 1rem;
    }
}
</style>
