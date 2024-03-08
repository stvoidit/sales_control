<template>
    <div>
        home
    </div>
</template>

<script setup>
fetch("/api/users").then((response) => {
    if (response.status === 401) {
        window.location.href = "/login";
    }
});
</script>
