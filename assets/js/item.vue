<template>
<div>
<h3>Open auctions</h3>
<table class="table">
    <thead>
      <tr>
        <th>Description</th>
        <th>Price</th>
        <th>Closing Date</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody id="items">
        <tr v-for="item in items" :key="item.id">
            <td>{{ item.description }}</td>
            <td>{{ item.price }}</td>
            <td>{{ item.closing_date }}</td>
            <td><router-link :id="index + 1" class="btn btn-primary" :to="{ name: 'bid', params: { item_id: item.id, description: item.description, closing_date: item.closing_date, price: item.price }}">Select</router-link> </td>
        </tr>
    </tbody>
</table>
</div>
</template>

<script>
import axios from "axios";

export default {
    data: function() {
      return {
        items: []
      }
    },
    mounted: function() {
      axios.get("/api/items")
                .then(response => {
                    this.items = response.data.items
                }).catch(error => {
                    console.log(error);
                });
    }
}

</script>