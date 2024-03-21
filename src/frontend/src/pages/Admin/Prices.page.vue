<template>
    <div class="row q-mt-md q-gutter-md justify-center">
        <div class="col-6">
            <q-table
                class="q-mt-md"
                :rows="prices"
                :grid="false"
                hide-pagination
                dense
                :columns="columnsPriceList"
                row-key="id">
                <template #body="props">
                    <q-tr :props="props">
                        <q-td
                            key="id"
                            :props="props">
                            {{ props.row.id }}
                        </q-td>
                        <q-td
                            key="label"
                            :props="props">
                            {{ props.row.label }}
                        </q-td>
                        <q-td
                            key="description"
                            :props="props">
                            {{ props.row.description }}
                        </q-td>
                        <q-td
                            key="articul"
                            :props="props">
                            {{ props.row.articul }}
                        </q-td>
                        <q-td
                            key="price"
                            :props="props">
                            {{ props.row.price }}
                            <q-popup-edit
                                v-slot="scope"
                                v-model="props.row.price"
                                buttons
                                persistent
                                @save="(value) => handleSavePrice( props.row.id, parseFloat(value))">
                                <q-input
                                    v-model="scope.value"
                                    dense
                                    type="number"
                                    autofocus
                                    @keyup.enter="scope.set" />
                            </q-popup-edit>
                        </q-td>
                        <q-td
                            key="updated"
                            :props="props">
                            {{ (new Date(props.row.updated)).toLocaleString() }}
                        </q-td>
                    </q-tr>
                </template>
            </q-table>
        </div>
    </div>
    <div class="row q-mt-md q-gutter-md justify-center">
        <div class="col-6">
            <q-table
                class="q-mt-md"
                :rows="history"
                :grid="false"
                :rows-per-page-options="[0]"
                :row-key="rowKeyHistory"
                :columns="columnsHistory"
                hide-pagination
                dense />
        </div>
    </div>
</template>

<script setup>
import { onMounted, shallowRef } from "vue";
import api from "@/api";
const prices = shallowRef([]);
const history = shallowRef([]);
const fetchData = () => Promise.all([
    api.getActualPrices().then(data => prices.value = data),
    api.getHistoryPrices().then(data => history.value = data)
]) ;
onMounted(fetchData);
const handleSavePrice = async (product_id, price) => {
    return await api.updateActualPrice({ product_id, price }).then(fetchData);
};
const rowKeyHistory = (row) => `${row.product_id}-${row.price}`;

const columnsPriceList = [
    {
        name: "id",
        field: "id",
        align: "left",
        label: "ID"
    },
    {
        name: "label",
        field: "label",
        align: "left",
        label: "название"
    },
    {
        name: "description",
        field: "description",
        align: "left",
        label: "описание"
    },
    {
        name: "articul",
        field: "articul",
        align: "left",
        label: "артикул"
    },
    {
        name: "price",
        field: "price",
        label: "цена",
        align: "left",
        format: (value) => value.toLocaleString()
    },
    {
        name: "updated",
        field: "updated",
        label: "дата установки цены",
        align: "left",
        format: (value) => (new Date(value)).toLocaleString()
    }
];
const columnsHistory = [
    {
        field: "product_id",
        align: "left",
        label: "ID"
    },
    {
        field: "label",
        align: "left",
        label: "название"
    },
    {
        field: "articul",
        align: "left",
        label: "артикул"
    },
    {
        field: "price",
        label: "цена",
        align: "left",
        format: (value) => value.toLocaleString()
    },
    {
        field: "price_date",
        label: "дата установки цены",
        align: "left",
        format: (value) => (new Date(value)).toLocaleString()
    }
];
</script>
